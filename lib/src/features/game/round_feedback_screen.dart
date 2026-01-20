import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/grid_background.dart';
import '../../core/theme.dart';
import '../../game_controller.dart';
import '../../models/role.dart';

import 'package:my_app/l10n/app_localizations.dart';

class RoundFeedbackScreen extends StatelessWidget {
  const RoundFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final eliminatedPlayer = controller.lastEliminatedPlayer;
    final wasSpy =
        eliminatedPlayer?.role == Role.impostor ||
        eliminatedPlayer?.role == Role.mrWhite;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GridBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: AppTheme.softShadows,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        wasSpy
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        size: 80,
                        color: wasSpy ? AppTheme.success : AppTheme.error,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        wasSpy
                            ? loc.busted.toUpperCase()
                            : loc.innocent.toUpperCase(),
                        style: textTheme.displayMedium?.copyWith(
                          color: wasSpy ? AppTheme.success : AppTheme.error,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        wasSpy
                            ? loc.youCaughtTheImpostor
                            : loc.youVotedOutInnocent,
                        style: textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: (wasSpy ? AppTheme.success : AppTheme.error)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(50), // Pill
                        ),
                        child: Text(
                          eliminatedPlayer?.name ?? '',
                          style: textTheme.headlineSmall?.copyWith(
                            color: wasSpy ? AppTheme.success : AppTheme.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.acknowledgeElimination,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shadowColor: AppTheme.primary.withValues(alpha: 0.5),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      loc.continueGame,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
