import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/word_packs.dart';
import '../models/word_pair.dart';
import 'ads_service.dart';

class MonetizationController extends ChangeNotifier {
  static const Duration _passDuration = Duration(hours: 24);

  static const String _prefsSeenWords = 'seen_word_ids';
  static const String _prefsDailyQuota = 'daily_word_quota';
  static const String _prefsLastReset = 'last_daily_reset';
  static const String _prefsPassExpiresAt = 'pass_expires_at';

  static const String _androidPassProductId = 'day_pass_24h';
  static const String _iosPassProductId = 'someonelying_noAdds_24';
  static const String purchaseErrorStream = 'purchase_error_stream';
  static const String purchaseErrorStoreUnavailable =
      'purchase_error_store_unavailable';
  static const String purchaseErrorStartFailed = 'purchase_error_start_failed';
  static const String purchaseErrorFailed = 'purchase_error_failed';
  static const String purchaseErrorCanceled = 'purchase_error_canceled';

  final AdsService _adsService = AdsService();
  final InAppPurchase _iap = InAppPurchase.instance;

  SharedPreferences? _prefs;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  bool _isInitialized = false;
  bool _isInitializing = false;
  bool _iapAvailable = false;
  bool _isPurchasePending = false;
  String? _purchaseError;
  ProductDetails? _passProduct;

  // New State
  Set<String> _seenWordIds = {};
  int _dailyQuota = 0;
  DateTime? _lastDailyReset;
  DateTime? _passExpiresAt;

  bool get isInitialized => _isInitialized;
  bool get isPurchasePending => _isPurchasePending;
  String? get purchaseError => _purchaseError;
  bool get isRewardedReady => _adsService.isRewardedReady;
  bool get isPassAvailable => _passProduct != null;

  // Public Getters
  int get dailyQuota => _dailyQuota;
  int get seenWordsCount => _seenWordIds.length;
  int get totalWords => WordPacks.allWords.length;

  bool get hasActivePass {
    final now = DateTime.now().toUtc();
    return _passExpiresAt != null && _passExpiresAt!.isAfter(now);
  }

  bool get canPlay {
    if (hasActivePass) return true;
    return _dailyQuota > 0;
  }

  ProductDetails? get passProduct => _passProduct;

  Future<void> init() async {
    if (_isInitialized || _isInitializing) {
      return;
    }
    _isInitializing = true;
    _prefs = await SharedPreferences.getInstance();

    // Load Data
    _seenWordIds = (_prefs?.getStringList(_prefsSeenWords) ?? []).toSet();
    _dailyQuota = _prefs?.getInt(_prefsDailyQuota) ?? 4;

    final lastResetMillis = _prefs?.getInt(_prefsLastReset) ?? 0;
    if (lastResetMillis > 0) {
      _lastDailyReset = DateTime.fromMillisecondsSinceEpoch(
        lastResetMillis,
        isUtc: true,
      );
    }

    final passExpiryMillis = _prefs?.getInt(_prefsPassExpiresAt) ?? 0;
    if (passExpiryMillis > 0) {
      _passExpiresAt = DateTime.fromMillisecondsSinceEpoch(
        passExpiryMillis,
        isUtc: true,
      );
    }

    _checkDailyReset();

    // Init Services
    _adsService.onRewardedStatusChanged = notifyListeners;
    await _adsService.initialize();

    _iapAvailable = await _iap.isAvailable();
    if (_iapAvailable) {
      await _queryProducts();
      _purchaseSubscription = _iap.purchaseStream.listen(
        _onPurchaseUpdated,
        onDone: () => _purchaseSubscription?.cancel(),
        onError: (_) {
          _isPurchasePending = false;
          _purchaseError = purchaseErrorStream;
          notifyListeners();
        },
      );
    }

    _isInitialized = true;
    _isInitializing = false;
    notifyListeners();
  }

  void _checkDailyReset() {
    final now = DateTime.now().toUtc();
    // Reset if last reset was yesterday or never
    // Simple check: different day of year or different year
    bool needsReset = false;
    if (_lastDailyReset == null) {
      needsReset = true;
    } else {
      final last = _lastDailyReset!;
      if (last.year != now.year ||
          last.month != now.month ||
          last.day != now.day) {
        needsReset = true;
      }
    }

    if (needsReset) {
      _dailyQuota = 4; // Reset to 4 free words
      _lastDailyReset = now;
      _persistDailyData();
      notifyListeners();
    }
  }

  Future<void> loadRewardedAd() async {
    await _adsService.loadRewardedAd();
  }

  static const int _maxDailyQuota = 4;

  Future<bool> unlockMoreWordsWithAd() async {
    final earned = await _adsService.showRewardedAd();
    if (!earned) {
      return false;
    }

    // User request: "In case, the user sees advertising video with the maxium number of words available do not add more but allow the user to see."
    if (_dailyQuota < _maxDailyQuota) {
      _dailyQuota = (_dailyQuota + 4).clamp(0, _maxDailyQuota).toInt();
    }

    await _persistDailyData();
    notifyListeners();
    return true;
  }

  // Called by GameController when finding a word
  WordPair? getNextWord(Locale locale) {
    // If not allowed, return null
    if (!canPlay) return null;

    final allWords = WordPacks.getWords(locale);
    final available = allWords
        .where((w) => !_seenWordIds.contains(w.id))
        .toList();
    if (available.isEmpty) {
      // User has seen ALL words for this locale.
      // Return random from all words to avoid crash
      if (allWords.isEmpty) return null; // Should not happen
      return allWords[Random().nextInt(allWords.length)];
    }

    final random = Random();
    return available[random.nextInt(available.length)];
  }

  // Called by GameController when game starts/finishes
  Future<void> consumeWord(String wordId) async {
    // Determine if we should consume quota
    if (!hasActivePass) {
      if (_dailyQuota > 0) {
        _dailyQuota--;
      }
    }

    // Mark as seen
    _seenWordIds.add(wordId);

    await _persistDailyData();
    await _persistSeenWords();
    notifyListeners();
  }

  Future<bool> purchaseDayPass() async {
    _purchaseError = null;
    if (!_iapAvailable || _passProduct == null) {
      _purchaseError = purchaseErrorStoreUnavailable;
      notifyListeners();
      return false;
    }

    _isPurchasePending = true;
    notifyListeners();

    final purchaseParam = PurchaseParam(productDetails: _passProduct!);
    try {
      // autoConsume: false — we complete the purchase manually only AFTER
      // _activatePass() succeeds, preventing a crash-between-consume-and-
      // activation from losing the user's payment.
      await _iap.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: false,
      );
      return true;
    } catch (error) {
      _isPurchasePending = false;
      _purchaseError = purchaseErrorStartFailed;
      notifyListeners();
      return false;
    }
  }

  Future<void> _queryProducts() async {
    final response = await _iap.queryProductDetails({_passProductId});
    if (response.notFoundIDs.isNotEmpty) {
      // Logic for dev/testing: create mock product if needed or just log
    }
    if (response.productDetails.isNotEmpty) {
      _passProduct = response.productDetails.first;
    }
  }

  Future<void> _onPurchaseUpdated(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) {
        _isPurchasePending = true;
        notifyListeners();
        continue;
      }

      if (purchase.status == PurchaseStatus.error) {
        _isPurchasePending = false;
        final purchaseMessage = purchase.error?.message.trim();
        _purchaseError = purchaseMessage?.isNotEmpty == true
            ? purchaseMessage
            : purchaseErrorFailed;
        notifyListeners();
        continue;
      }

      if (purchase.status == PurchaseStatus.canceled) {
        _isPurchasePending = false;
        _purchaseError = purchaseErrorCanceled;
        notifyListeners();
        continue;
      }

      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        // Activate the pass FIRST, then complete/consume the transaction.
        // This guarantees the user always gets what they paid for even if
        // the app is killed between the two steps on the next cold start.
        await _activatePass();
        _isPurchasePending = false;
        _purchaseError = null;
      }

      // Complete the purchase only after activation (autoConsume: false).
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
    notifyListeners();
  }

  Future<void> _activatePass() async {
    final now = DateTime.now().toUtc();
    _passExpiresAt = now.add(_passDuration);
    await _persistPassExpiry();
    notifyListeners();
  }

  void clearPurchaseError() {
    _purchaseError = null;
    notifyListeners();
  }

  /// Restores any previous purchases for the current user.
  /// Required by Apple App Review Guidelines (3.1.1) for apps with IAP.
  Future<void> restorePurchases() async {
    if (!_iapAvailable) return;
    _isPurchasePending = true;
    _purchaseError = null;
    notifyListeners();
    try {
      await _iap.restorePurchases();
    } catch (_) {
      _isPurchasePending = false;
      _purchaseError = purchaseErrorStartFailed;
      notifyListeners();
    }
  }

  // Persistence Helpers

  Future<void> _persistDailyData() async {
    if (_prefs == null) return;
    await _prefs!.setInt(_prefsDailyQuota, _dailyQuota);
    if (_lastDailyReset != null) {
      await _prefs!.setInt(
        _prefsLastReset,
        _lastDailyReset!.millisecondsSinceEpoch,
      );
    }
  }

  Future<void> _persistSeenWords() async {
    if (_prefs == null) return;
    await _prefs!.setStringList(_prefsSeenWords, _seenWordIds.toList());
  }

  Future<void> _persistPassExpiry() async {
    if (_prefs == null) return;
    if (_passExpiresAt == null) {
      await _prefs!.remove(_prefsPassExpiresAt);
    } else {
      await _prefs!.setInt(
        _prefsPassExpiresAt,
        _passExpiresAt!.millisecondsSinceEpoch,
      );
    }
  }

  String get _passProductId {
    if (Platform.isIOS) {
      return _iosPassProductId;
    }
    return _androidPassProductId;
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    _adsService.onRewardedStatusChanged = null;
    _adsService.dispose();
    super.dispose();
  }
}
