import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/grid_background.dart';
import '../../game_controller.dart';
import '../../core/confirm_exit.dart';
import '../../core/theme.dart';
import '../../models/winner_type.dart';

import 'package:my_app/l10n/app_localizations.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final winner = controller.winner;
    final isSpyWin = winner == WinnerType.spy;
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        (isSpyWin ? theme.colorScheme.error : AppTheme.success)
                            .withValues(alpha: 0.1),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isSpyWin
                                    ? theme.colorScheme.error
                                    : AppTheme.success)
                                .withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(
                    isSpyWin ? Icons.person_off_rounded : Icons.shield_rounded,
                    size: 100,
                    color: isSpyWin
                        ? theme.colorScheme.error
                        : AppTheme.success,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  isSpyWin
                      ? loc.spyWin.toUpperCase()
                      : loc.civilianWin.toUpperCase(),
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isSpyWin
                        ? theme.colorScheme.error
                        : AppTheme.success,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isSpyWin
                      ? loc.spyEvadedDetection
                      : loc.hiddenThreatEliminated,
                  style: textTheme.titleLarge?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
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
                          color: theme.hintColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.secretWord.toUpperCase(),
                        style: textTheme.displaySmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
