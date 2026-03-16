import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/l10n/app_localizations.dart';
import '../../core/grid_background.dart';
import '../../core/theme.dart';
import '../../game_controller.dart';
import '../../monetization/monetization_controller.dart';
import '../../features/settings/settings_controller.dart';
import '../../features/settings/settings_screen.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MonetizationController>().loadRewardedAd();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addPlayer() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      context.read<GameController>().addPlayer(name);
      _nameController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  IconData _getAvatarIcon(int index) {
    final icons = [
      Icons.person,
      Icons.face,
      Icons.emoji_emotions,
      Icons.sentiment_satisfied_alt,
      Icons.tag_faces,
      Icons.mood,
      Icons.account_circle,
      Icons.person_outline,
    ];
    return icons[index % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final loc = AppLocalizations.of(context)!;
    final monetization = context.watch<MonetizationController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final hasValidSetup = controller.hasValidSetup;
    final isDark = theme.brightness == Brightness.dark;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    const bottomBarHeight = 84.0;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Handle keyboard properly
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          tooltip: loc.settings,
          icon: const Icon(Icons.settings_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    SettingsScreen(playerCount: controller.players.length),
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loc.lobbyTitle.toUpperCase(),
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<SettingsController>(
            builder: (context, settings, child) {
              return IconButton(
                icon: Icon(
                  settings.themeMode == ThemeMode.dark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                ),
                onPressed: () {
                  settings.updateThemeMode(
                    settings.themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GridBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 4),

              // Top Section: Word Quota (Full Width)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _WordPackStatusCard(monetization: monetization),
              ),

              const SizedBox(height: 6),

              // Settings Summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(
                            playerCount: controller.players.length,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: theme.dividerColor.withValues(alpha: 0.38),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            color: theme.colorScheme.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc.settingsTitle,
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${loc.impostorsShort}: ${controller.impostorCount} • '
                                  '${loc.mrWhiteShort}: ${controller.mrWhiteCount}',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Player List Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: AppTheme.cardRadius,
                      boxShadow: AppTheme.softShadows,
                      border: Border.all(
                        color: theme.dividerColor.withValues(alpha: 0.38),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Players Header
                        Row(
                          children: [
                            Text(
                              loc.players,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${controller.players.length}',
                                style: textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.people_alt_rounded,
                              color: theme.colorScheme.onSurfaceVariant,
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Scrollable Player List
                        Expanded(
                          child: controller.players.isEmpty
                              ? Center(
                                  child: Text(
                                    loc.needPlayersToStart(
                                      controller.minPlayersRequired,
                                    ),
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: theme.hintColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: controller.players.length,
                                  itemBuilder: (context, index) {
                                    final player = controller.players[index];
                                    final listItemBg = isDark
                                        ? theme.colorScheme.surface.withValues(
                                            alpha: 0.85,
                                          )
                                        : theme.colorScheme.secondary
                                              .withValues(alpha: 0.06);
                                    final listItemBorder = isDark
                                        ? theme.colorScheme.secondary
                                              .withValues(alpha: 0.35)
                                        : theme.colorScheme.secondary
                                              .withValues(alpha: 0.14);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Dismissible(
                                        key: Key(player.id),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (_) {
                                          controller.removePlayer(player.id);
                                        },
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                            right: 18,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.error,
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.delete_outline_rounded,
                                            color: theme.colorScheme.onError,
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: listItemBg,
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            border: Border.all(
                                              color: listItemBorder,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: isDark ? 0.22 : 0.08,
                                                ),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Player Avatar Icon
                                              Container(
                                                width: 34,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      theme.colorScheme.primary
                                                          .withValues(
                                                            alpha: isDark
                                                                ? 0.9
                                                                : 0.85,
                                                          ),
                                                      theme
                                                          .colorScheme
                                                          .secondary
                                                          .withValues(
                                                            alpha: isDark
                                                                ? 0.9
                                                                : 0.85,
                                                          ),
                                                    ],
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  _getAvatarIcon(index),
                                                  color: theme
                                                      .colorScheme
                                                      .onPrimary,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  player.name,
                                                  style: textTheme.titleSmall
                                                      ?.copyWith(
                                                        color: theme
                                                            .colorScheme
                                                            .onSurface,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => controller
                                                    .removePlayer(player.id),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    6,
                                                  ),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: theme
                                                        .colorScheme
                                                        .error
                                                        .withValues(
                                                          alpha: 0.75,
                                                        ),
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),

                        const SizedBox(height: 12),

                        // Add Player Input (At bottom of player list)
                        Container(
                          decoration: BoxDecoration(
                            color: theme.inputDecorationTheme.fillColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: TextField(
                            controller: _nameController,
                            style: textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: loc.enterPlayerName,
                              hintStyle: textTheme.bodyMedium?.copyWith(
                                color: theme.hintColor,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Material(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: _addPlayer,
                                    child: SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: theme.colorScheme.onPrimary,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _addPlayer(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: keyboardOpen
          ? null
          : Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor.withValues(alpha: 0.38),
                  ),
                ),
              ),
              child: SizedBox(
                height: bottomBarHeight - 28,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!hasValidSetup) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            loc.needPlayersToStart(controller.minPlayersRequired),
                          ),
                        ),
                      );
                      return;
                    }
                    if (!monetization.canPlay) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.dailyLimitReached)),
                      );
                      showModalBottomSheet<bool>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => const _UnlockWordsSheet(),
                      );
                      return;
                    }
                    controller.startGame(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: theme.colorScheme.primary.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  child: Text(
                    loc.startGame,
                    style: textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _WordPackStatusCard extends StatelessWidget {
  final MonetizationController monetization;

  const _WordPackStatusCard({required this.monetization});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    final quota = monetization.dailyQuota;
    final hasPass = monetization.hasActivePass;
    final progress = hasPass ? 1.0 : (quota / 4).clamp(0.0, 1.0);
    final progressColor = hasPass
        ? theme.colorScheme.primary
        : (quota > 0 ? theme.colorScheme.primary : theme.colorScheme.error);

    String statusText;
    if (hasPass) {
      statusText = loc.premiumActive;
    } else if (quota > 0) {
      statusText = loc.freeRoundsRemaining(quota);
    } else {
      statusText = loc.dailyLimitReached;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => const _UnlockWordsSheet(),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withValues(
                  alpha: isDark ? 0.18 : 0.12,
                ),
                theme.cardTheme.color!,
                theme.colorScheme.secondary.withValues(
                  alpha: isDark ? 0.18 : 0.08,
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: (hasPass ? theme.colorScheme.primary : theme.dividerColor)
                  .withValues(alpha: 0.18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.28 : 0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary.withValues(
                            alpha: isDark ? 0.9 : 0.85,
                          ),
                          theme.colorScheme.secondary.withValues(
                            alpha: isDark ? 0.9 : 0.85,
                          ),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.bolt_rounded,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.dailyWords,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          statusText,
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: hasPass
                          ? theme.colorScheme.primary.withValues(alpha: 0.16)
                          : (quota > 0
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.14,
                                  )
                                : theme.colorScheme.error.withValues(
                                    alpha: 0.14,
                                  )),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: hasPass
                            ? theme.colorScheme.primary.withValues(alpha: 0.3)
                            : (quota > 0
                                  ? theme.colorScheme.primary.withValues(
                                      alpha: 0.3,
                                    )
                                  : theme.colorScheme.error.withValues(
                                      alpha: 0.3,
                                    )),
                      ),
                    ),
                    child: Text(
                      hasPass ? loc.premium : '$quota/4',
                      style: textTheme.labelMedium?.copyWith(
                        color: hasPass
                            ? theme.colorScheme.primary
                            : (quota > 0
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.error),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: theme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        valueColor: AlwaysStoppedAnimation(progressColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    hasPass ? loc.unlimited : loc.roundsLeft,
                    style: textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnlockWordsSheet extends StatefulWidget {
  const _UnlockWordsSheet();

  @override
  State<_UnlockWordsSheet> createState() => _UnlockWordsSheetState();
}

class _UnlockWordsSheetState extends State<_UnlockWordsSheet> {
  bool _isWorking = false;
  String? _localError;

  String? _resolvePurchaseErrorMessage(
    AppLocalizations loc,
    String? purchaseError,
  ) {
    switch (purchaseError) {
      case MonetizationController.purchaseErrorStream:
        return loc.purchaseStreamError;
      case MonetizationController.purchaseErrorStoreUnavailable:
        return loc.purchaseStoreUnavailable;
      case MonetizationController.purchaseErrorStartFailed:
        return loc.purchaseStartFailed;
      case MonetizationController.purchaseErrorFailed:
        return loc.purchaseFailed;
      case MonetizationController.purchaseErrorCanceled:
        return loc.purchaseCanceled;
      default:
        return purchaseError;
    }
  }

  Future<void> _watchAd(MonetizationController monetization) async {
    if (_isWorking) return;
    final loc = AppLocalizations.of(context)!;
    setState(() {
      _isWorking = true;
      _localError = null;
    });
    final success = await monetization.unlockMoreWordsWithAd();
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _isWorking = false;
      _localError = loc.adNotCompletedTryAgain;
    });
  }

  Future<void> _buyPass(MonetizationController monetization) async {
    if (_isWorking) return;
    final loc = AppLocalizations.of(context)!;
    setState(() {
      _isWorking = true;
      _localError = null;
    });
    monetization.clearPurchaseError();
    final success = await monetization.purchaseDayPass();
    if (!mounted) return;
    if (!success) {
      setState(() {
        _isWorking = false;
        _localError = _resolvePurchaseErrorMessage(
          loc,
          monetization.purchaseError,
        );
      });
      return;
    }
    setState(() => _isWorking = false);
  }

  Future<void> _restorePurchases(MonetizationController monetization) async {
    if (_isWorking) return;
    setState(() {
      _isWorking = true;
      _localError = null;
    });
    await monetization.restorePurchases();
    if (!mounted) return;
    setState(() => _isWorking = false);
  }

  @override
  Widget build(BuildContext context) {
    final monetization = context.watch<MonetizationController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    final priceLabel = monetization.passProduct?.price ?? loc.dayPassFallback;

    if (monetization.hasActivePass) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).pop(true);
      });
    }

    final errorMessage =
        _localError ??
        _resolvePurchaseErrorMessage(loc, monetization.purchaseError);
    final isBusy = _isWorking || monetization.isPurchasePending;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.38)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loc.needMoreWords,
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              loc.watchAdOrPass,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.85,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (errorMessage != null)
              Text(
                errorMessage,
                style: textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            if (errorMessage != null) const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: (!isBusy && monetization.isRewardedReady)
                  ? () => _watchAd(monetization)
                  : null,
              icon: const Icon(Icons.ondemand_video_rounded),
              label: Text(loc.watchAd),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: !isBusy ? () => _buyPass(monetization) : null,
              icon: const Icon(Icons.lock_open_rounded),
              label: Text(loc.getPass(priceLabel)),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: isBusy ? null : () => Navigator.of(context).pop(false),
              child: Text(loc.notNow),
            ),
            TextButton(
              onPressed: isBusy ? null : () => _restorePurchases(monetization),
              child: Text(
                loc.restorePurchases,
                style: textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
