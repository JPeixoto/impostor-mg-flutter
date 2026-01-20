import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/l10n/app_localizations.dart';
import '../../core/grid_background.dart';
import '../../core/theme.dart';
import '../../game_controller.dart';
import '../../monetization/monetization_controller.dart';
import '../../features/settings/settings_controller.dart';

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

    return Scaffold(
      resizeToAvoidBottomInset: true, // Handle keyboard properly
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loc.lobbyTitle.toUpperCase(),
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
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
              const SizedBox(height: 8),

              // Top Section: Word Quota (Full Width)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _WordPackStatusCard(monetization: monetization),
              ),

              const SizedBox(height: 8),

              // Mr. White Toggle (Below Word Quota)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.cardTheme.color!,
                        theme.colorScheme.primary.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.psychology_rounded,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.mrWhite,
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              loc.mrWhiteDescription,
                              style: textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: controller.useMrWhite,
                        onChanged: (val) {
                          setState(() => controller.useMrWhite = val);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Expanded Player List Section (Takes Most of Screen)
              Expanded(
                flex: 10, // Much larger flex to dominate the screen
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: AppTheme.softShadows,
                      border: Border.all(
                        color: theme.dividerColor.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Players Header
                        Text(
                          "Players (${controller.players.length})",
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Scrollable Player List
                        Expanded(
                          child: controller.players.isEmpty
                              ? Center(
                                  child: Text(
                                    loc.waitingForPlayers,
                                    style: textTheme.titleMedium?.copyWith(
                                      color: theme.hintColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: controller.players.length,
                                  itemBuilder: (context, index) {
                                    final player = controller.players[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
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
                                            right: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.error,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              // Player Avatar Icon
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  _getAvatarIcon(index),
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  player.name,
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                        color: Colors.white,
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
                                                    4,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.white,
                                                    size: 20,
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

                        const SizedBox(height: 16),

                        // Add Player Input (At bottom of player list)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.inputDecorationTheme.fillColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: theme.dividerColor),
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  style: textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    hintText: loc.enterPlayerName,
                                    hintStyle: textTheme.bodyLarge?.copyWith(
                                      color: theme.hintColor,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  onSubmitted: (_) => _addPlayer(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: _addPlayer,
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: theme.colorScheme.onPrimary,
                                ),
                                style: IconButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Fixed Bottom: Start Button Only
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                  border: Border(
                    top: BorderSide(
                      color: theme.dividerColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.players.length >= 3
                        ? () => controller.startGame(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      disabledBackgroundColor: theme.disabledColor.withValues(
                        alpha: 0.1,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: controller.players.length >= 3 ? 8 : 0,
                      shadowColor: theme.primaryColor.withValues(alpha: 0.5),
                    ),
                    child: Text(
                      loc.startGame,
                      style: textTheme.titleMedium?.copyWith(
                        color: controller.players.length >= 3
                            ? theme.colorScheme.onPrimary
                            : theme.disabledColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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

    final quota = monetization.dailyQuota;
    final hasPass = monetization.hasActivePass;

    String statusText;
    if (hasPass) {
      statusText = loc.premiumActive;
    } else if (quota > 0) {
      statusText = loc.freeRoundsRemaining(quota);
    } else {
      statusText = loc.dailyLimitReached;
    }

    return GestureDetector(
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.cardTheme.color!,
              theme.colorScheme.secondary.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.secondary.withValues(alpha: 0.15),
              ),
              child: Icon(
                Icons.bolt_rounded,
                color: theme.colorScheme.secondary,
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
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
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
            if (!hasPass)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: quota > 0
                      ? theme.colorScheme.primary.withValues(alpha: 0.15)
                      : theme.colorScheme.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$quota/4',
                  style: textTheme.labelMedium?.copyWith(
                    color: quota > 0
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (hasPass)
              Icon(
                Icons.check_circle_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
          ],
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

  Future<void> _watchAd(MonetizationController monetization) async {
    if (_isWorking) return;
    setState(() => _isWorking = true);
    final success = await monetization.unlockMoreWordsWithAd();
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _isWorking = false;
      _localError = 'Ad was not completed. Try again.';
    });
  }

  Future<void> _buyPass(MonetizationController monetization) async {
    if (_isWorking) return;
    setState(() => _isWorking = true);
    monetization.clearPurchaseError();
    final success = await monetization.purchaseDayPass();
    if (!mounted) return;
    if (!success) {
      setState(() {
        _isWorking = false;
        _localError = monetization.purchaseError;
      });
      return;
    }
    setState(() => _isWorking = false);
  }

  @override
  Widget build(BuildContext context) {
    final monetization = context.watch<MonetizationController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    final priceLabel = monetization.passProduct?.price ?? '24h pass';

    if (monetization.hasActivePass) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).pop(true);
      });
    }

    final errorMessage = _localError ?? monetization.purchaseError;
    final isBusy = _isWorking || monetization.isPurchasePending;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
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
          ],
        ),
      ),
    );
  }
}
