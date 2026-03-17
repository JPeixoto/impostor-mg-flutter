// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/src/app.dart';
import 'package:my_app/src/features/onboarding/onboarding_screen.dart';
import 'package:my_app/src/models/game_state.dart';
import 'package:my_app/src/monetization/monetization_controller.dart';

void main() {
  testWidgets('App starts in onboarding flow', (WidgetTester tester) async {
    final monetizationController = MonetizationController();
    monetizationController.startPurchaseListener();
    unawaited(monetizationController.init());

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(
        initialGameState: GameState.onboarding,
        monetizationController: monetizationController,
      ),
    );

    // Verify that we start on onboarding.
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
