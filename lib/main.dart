import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'src/app.dart';
import 'src/core/onboarding_gate.dart';
import 'src/models/game_state.dart';
import 'src/monetization/monetization_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS || Platform.isMacOS) {
    // ignore: deprecated_member_use
    await InAppPurchaseStoreKitPlatform.enableStoreKit1();
  }
  final onboarding = await OnboardingGate.resolve();
  final initialState = onboarding.shouldShowOnboarding
      ? GameState.onboarding
      : GameState.lobby;
  final monetizationController = MonetizationController();
  monetizationController.startPurchaseListener();
  unawaited(monetizationController.init());

  runApp(
    MyApp(
      initialGameState: initialState,
      monetizationController: monetizationController,
    ),
  );
}
