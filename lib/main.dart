import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/core/onboarding_gate.dart';
import 'src/models/game_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final onboarding = await OnboardingGate.resolve();
  final initialState = onboarding.shouldShowOnboarding
      ? GameState.onboarding
      : GameState.lobby;

  runApp(MyApp(initialGameState: initialState));
}
