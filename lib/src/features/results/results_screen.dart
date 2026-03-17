import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/grid_background.dart';
import '../../game_controller.dart';
import '../../core/confirm_exit.dart';
import '../../core/theme.dart';
import '../../models/role.dart';
import '../../models/winner_type.dart';

import 'package:my_app/l10n/app_localizations.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final winner = controller.winner;
    final isSpyWin = winner == WinnerType.spy;
    final wordPair = controller.currentWordPair;
    final civilianWord = wordPair?.civilianWord ?? '?';
    final impostorWord = wordPair?.impostorWord ?? '?';
    final hasImpostor = controller.players.any(
      (player) => player.role == Role.impostor,
    );
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          loc.results.toUpperCase(),
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: loc.backToLobby,
            icon: const Icon(Icons.close_rounded),
            onPressed: () =>
                confirmExitToLobby(context, onConfirm: controller.resetGame),
          ),
        ],
      ),
      body: GridBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              final scale = height < 680
                  ? 0.74
                  : height < 760
                  ? 0.84
                  : height < 860
                  ? 0.92
                  : 1.0;

              return Padding(
                padding: EdgeInsets.fromLTRB(24, 8 * scale, 24, 16 * scale),
                child: Column(
                  children: [
                    SizedBox(height: 8 * scale),
                    Container(
                      padding: EdgeInsets.all(40 * scale),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (isSpyWin
                                    ? theme.colorScheme.error
                                    : AppTheme.success)
                                .withValues(alpha: 0.1),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (isSpyWin
                                        ? theme.colorScheme.error
                                        : AppTheme.success)
                                    .withValues(alpha: 0.2),
                            blurRadius: 40 * scale,
                            spreadRadius: 10 * scale,
                          ),
                        ],
                      ),
                      child: Icon(
                        isSpyWin
                            ? Icons.person_off_rounded
                            : Icons.shield_rounded,
                        size: 100 * scale,
                        color: isSpyWin
                            ? theme.colorScheme.error
                            : AppTheme.success,
                      ),
                    ),
                    SizedBox(height: 24 * scale),
                    Text(
                      isSpyWin
                          ? loc.spyWin.toUpperCase()
                          : loc.civilianWin.toUpperCase(),
                      style: textTheme.displayMedium?.copyWith(
                        fontSize:
                            (textTheme.displayMedium?.fontSize ?? 42) * scale,
                        fontWeight: FontWeight.w900,
                        color: isSpyWin
                            ? theme.colorScheme.error
                            : AppTheme.success,
                        letterSpacing: -1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12 * scale),
                    Text(
                      isSpyWin
                          ? loc.spyEvadedDetection
                          : loc.hiddenThreatEliminated,
                      style: textTheme.titleLarge?.copyWith(
                        fontSize:
                            (textTheme.titleLarge?.fontSize ?? 22) * scale,
                        color: theme.textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24 * scale),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(28 * scale),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: AppTheme.cardRadius,
                        boxShadow: AppTheme.softShadows,
                      ),
                      child: Column(
                        children: [
                          Text(
                            loc.secretWordWas.toUpperCase(),
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize:
                                  (textTheme.bodyMedium?.fontSize ?? 14) *
                                  scale,
                              color: theme.hintColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 18 * scale),
                          _WordRevealTile(
                            label: loc.civilian,
                            word: civilianWord,
                            color: theme.colorScheme.secondary,
                            scale: scale,
                          ),
                          if (hasImpostor) ...[
                            SizedBox(height: 14 * scale),
                            _WordRevealTile(
                              label: loc.spy,
                              word: impostorWord,
                              color: theme.colorScheme.error,
                              scale: scale,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.resetGame,
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(loc.playAgain),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20 * scale),
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shadowColor: theme.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          textStyle: textTheme.titleMedium?.copyWith(
                            fontSize:
                                (textTheme.titleMedium?.fontSize ?? 16) * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8 * scale),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _WordRevealTile extends StatelessWidget {
  const _WordRevealTile({
    required this.label,
    required this.word,
    required this.color,
    required this.scale,
  });

  final String label;
  final String word;
  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 16 * scale,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: textTheme.labelLarge?.copyWith(
              fontSize: (textTheme.labelLarge?.fontSize ?? 14) * scale,
              color: color,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10 * scale),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              word.toUpperCase(),
              style: textTheme.headlineMedium?.copyWith(
                fontSize: (textTheme.headlineMedium?.fontSize ?? 28) * scale,
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
