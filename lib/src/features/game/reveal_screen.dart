import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/l10n/app_localizations.dart';
import '../../core/grid_background.dart';
import '../../core/theme.dart';
import '../../game_controller.dart';
import '../../models/role.dart';

class RevealScreen extends StatelessWidget {
  const RevealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final player = controller.currentPlayer;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    if (player == null) {
      return const SizedBox.shrink();
    }

    final isImpostor = player.role == Role.impostor;
    final isMrWhite = player.role == Role.mrWhite;
    final isBadGuy = isImpostor || isMrWhite;

    // Secret word logic: Mr White sees "???" or their specific word if we had one (but description says knows nothing)
    // Impostor also doesn't know the word usually, but let's stick to the prompt's logic.
    // The previous code had:
    // final secretWord = controller.currentWordPair?.civilianWord ?? '???';
    // And showed it if NOT spy.
    // Mr White should NOT see the secret word.

    final secretWord = controller.currentWordPair?.civilianWord ?? '???';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          loc.yourRole.toUpperCase(),
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: GridBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: AppTheme.softShadows,
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (isBadGuy
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.secondary)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color:
                                (isBadGuy
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.secondary)
                                    .withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          isImpostor
                              ? loc.youAreTheImpostor
                              : isMrWhite
                              ? loc.mrWhite.toUpperCase()
                              : loc.youAreACitizen,
                          style: textTheme.labelLarge?.copyWith(
                            color: isBadGuy
                                ? theme.colorScheme.error
                                : theme.colorScheme.secondary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (isBadGuy)
                        Icon(
                          Icons.visibility_off_rounded,
                          size: 80,
                          color: theme.colorScheme.error,
                        )
                      else
                        Icon(
                          Icons.vpn_key_rounded,
                          size: 80,
                          color: theme.colorScheme.secondary,
                        ),
                      const SizedBox(height: 32),
                      if (isBadGuy) ...[
                        Text(
                          loc.blendIn.toUpperCase(),
                          style: textTheme.displayMedium?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isMrWhite
                              ? loc.mrWhiteDescription
                              : loc.impostorInstruction,
                          style: textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ] else ...[
                        Text(
                          loc.theSecretWord,
                          style: textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.secondary,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            secretWord.toUpperCase(),
                            style: textTheme.displayMedium?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          loc.dontBeTooObvious,
                          style: textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.softShadows,
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            color: theme.colorScheme.onSurface,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            loc.nextUp,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.passDeviceInstruction,
                        style: textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.nextPlayerReveal,
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
                    ),
                    child: Text(
                      loc.gotIt,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
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
