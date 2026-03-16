import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/l10n/app_localizations.dart';
import '../../core/grid_background.dart';
import '../../core/confirm_exit.dart';
import '../../core/theme.dart';
import '../../game_controller.dart';
import '../../models/game_state.dart';

class TurnScreen extends StatefulWidget {
  const TurnScreen({super.key});

  @override
  State<TurnScreen> createState() => _TurnScreenState();
}

class _TurnScreenState extends State<TurnScreen> {
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

    final name = player.name;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    final isTurnTaking = controller.currentState == GameState.turnTaking;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            (isTurnTaking ? loc.yourTurn : loc.passThePhone(name))
                .toUpperCase(),
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
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
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.scaffoldBackgroundColor,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  initial,
                                  style: GoogleFonts.sora(
                                    fontSize: 64,
                                    color: theme.colorScheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              isTurnTaking
                                  ? loc.itsNamesTurn(name)
                                  : loc.passToName(name),
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              isTurnTaking
                                  ? loc.askQuestion
                                  : loc.dontLetOthersSee,
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 48),
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: AppTheme.cardRadius,
                                boxShadow: AppTheme.softShadows,
                                border: Border.all(
                                  color: theme.dividerColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  if (isTurnTaking) ...[
                                    _InstructionRow(
                                      icon: Icons.record_voice_over_rounded,
                                      text: loc.askYesNoQuestion,
                                      color: theme.colorScheme.primary,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      child: Divider(
                                        height: 1,
                                        color: theme.dividerColor.withValues(
                                          alpha: 0.2,
                                        ),
                                      ),
                                    ),
                                    _InstructionRow(
                                      icon: Icons.check_circle_rounded,
                                      text: loc.tapDoneWhenFinished,
                                      color: theme.colorScheme.secondary,
                                    ),
                                  ] else ...[
                                    _InstructionRow(
                                      icon: Icons.visibility_off_rounded,
                                      text: loc.keepScreenHidden,
                                      color: theme.colorScheme.primary,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      child: Divider(
                                        height: 1,
                                        color: theme.dividerColor.withValues(
                                          alpha: 0.2,
                                        ),
                                      ),
                                    ),
                                    _InstructionRow(
                                      icon: Icons.touch_app_rounded,
                                      text: loc.tapRevealWhenReady,
                                      color: theme.colorScheme.secondary,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isTurnTaking
                                  ? controller.nextTurn
                                  : controller.revealRole,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shadowColor: theme.colorScheme.primary
                                    .withValues(alpha: 0.5),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isTurnTaking
                                        ? Icons.check_rounded
                                        : Icons.remove_red_eye_rounded,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      isTurnTaking
                                          ? loc.doneNextPlayer
                                          : loc.iAmNameRevealRole(name),
                                      style: textTheme.titleMedium?.copyWith(
                                        color: theme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}

class _InstructionRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InstructionRow({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
