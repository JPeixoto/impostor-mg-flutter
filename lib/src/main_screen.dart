import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_controller.dart';
import 'models/game_state.dart';
import 'features/lobby/lobby_screen.dart';
import 'features/game/reveal_screen.dart';
import 'features/game/game_screen.dart';
import 'features/results/results_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/game/turn_screen.dart';
import 'features/game/round_feedback_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, controller, child) {
        switch (controller.currentState) {
          case GameState.onboarding:
            return const OnboardingScreen();
          case GameState.lobby:
            return const LobbyScreen();
          case GameState.reveal:
            return controller.isRoleRevealed
                ? const RevealScreen()
                : const TurnScreen();
          case GameState.turnTaking:
            return const TurnScreen();
          case GameState.discussion:
          case GameState.voting:
            return const GameScreen();
          case GameState.roundFeedback:
            return const RoundFeedbackScreen();
          case GameState.results:
            return const ResultsScreen();
        }
      },
    );
  }
}
