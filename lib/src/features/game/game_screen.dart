import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/grid_background.dart';
import '../../core/theme.dart';
import '../../game_controller.dart';
import '../../models/game_state.dart';

import 'package:my_app/l10n/app_localizations.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final isDiscussion = controller.currentState == GameState.discussion;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          (isDiscussion ? loc.discussionRoom : loc.votingBooth).toUpperCase(),
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: AppTheme.softShadows,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (isDiscussion
                                          ? theme.colorScheme.secondary
                                          : theme.colorScheme.primary)
                                      .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              isDiscussion
                                  ? loc.discuss.toUpperCase()
                                  : loc.vote.toUpperCase(),
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: isDiscussion
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          if (isDiscussion)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loc.timeToDiscuss,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: theme.hintColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    loc.shareHints,
                                    style: textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loc.castYourVote,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: theme.hintColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    loc.pickWhoToEliminate,
                                    style: textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: isDiscussion
                      ? _DiscussionTimer(
                          timeLeft: controller.timeLeft,
                          formatTime: _formatTime,
                        )
                      : _VotingList(controller: controller),
                ),
              ),
              if (isDiscussion)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.startVoting,
                      icon: const Icon(Icons.how_to_vote_rounded, size: 22),
                      label: Text(loc.callAVote),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 8,
                        shadowColor: theme.colorScheme.primary.withValues(
                          alpha: 0.5,
                        ),
                        textStyle: textTheme.titleMedium?.copyWith(
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

class _DiscussionTimer extends StatelessWidget {
  final int timeLeft;
  final String Function(int) formatTime;

  const _DiscussionTimer({required this.timeLeft, required this.formatTime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;
    final progress = (timeLeft / 240).clamp(0.0, 1.0).toDouble();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(32),
          boxShadow: AppTheme.softShadows,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 240,
                  width: 240,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 16,
                    backgroundColor: theme.dividerColor.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation(
                      timeLeft < 30
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatTime(timeLeft),
                      style: GoogleFonts.outfit(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loc.remaining.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme.hintColor,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                loc.tradeHints,
                style: textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VotingList extends StatelessWidget {
  final GameController controller;

  const _VotingList({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    final players = controller.players.where((p) => !p.isEliminated).toList();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: players.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final player = players[index];
        final name = player.name;
        final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

        return GestureDetector(
          onTap: () => controller.eliminatePlayer(player),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppTheme.softShadows,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary, // Black
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: textTheme.titleLarge?.copyWith(
                        color: Colors.white, // Always white on secondary
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc.tapToVoteOut,
                        style: textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.how_to_vote_rounded,
                        color: AppTheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        loc.vote.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
