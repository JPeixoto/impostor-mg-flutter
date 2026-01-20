import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  AdsService({this.onRewardedStatusChanged});

  VoidCallback? onRewardedStatusChanged;
  RewardedAd? _rewardedAd;
  bool _isLoading = false;

  bool get isRewardedReady => _rewardedAd != null;

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    await loadRewardedAd();
  }

  Future<void> loadRewardedAd() async {
    if (_isLoading || _rewardedAd != null) {
      return;
    }
    _isLoading = true;

    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoading = false;
          onRewardedStatusChanged?.call();
        },
        onAdFailedToLoad: (_) {
          _rewardedAd = null;
          _isLoading = false;
          onRewardedStatusChanged?.call();
        },
      ),
    );
  }

  Future<bool> showRewardedAd() async {
    final ad = _rewardedAd;
    if (ad == null) {
      return false;
    }

    final completer = Completer<bool>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        if (!completer.isCompleted) {
          completer.complete(false);
        }
        onRewardedStatusChanged?.call();
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        _rewardedAd = null;
        if (!completer.isCompleted) {
          completer.complete(false);
        }
        onRewardedStatusChanged?.call();
        loadRewardedAd();
      },
    );

    ad.show(
      onUserEarnedReward: (_, __) {
        if (!completer.isCompleted) {
          completer.complete(true);
        }
      },
    );

    final earned = await completer.future;
    return earned;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    onRewardedStatusChanged?.call();
  }

  String get _rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    }
    return '';
  }
}
