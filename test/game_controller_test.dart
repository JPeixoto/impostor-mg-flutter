import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/src/game_controller.dart';
import 'package:my_app/src/models/game_state.dart';
import 'package:my_app/src/models/winner_type.dart';

void main() {
  group('GameController', () {
    late GameController controller;

    setUp(() {
      controller = GameController(initialState: GameState.lobby);
    });

    tearDown(() {
      controller.dispose();
    });

    test('initial state is lobby', () {
      expect(controller.currentState, GameState.lobby);
      expect(controller.players, isEmpty);
      expect(controller.winner, WinnerType.none);
    });

    test('addPlayer adds a player and notifies listeners', () {
      var notified = false;
      controller.addListener(() => notified = true);
      controller.addPlayer('Alice');
      expect(controller.players.length, 1);
      expect(controller.players.first.name, 'Alice');
      expect(notified, isTrue);
    });

    test('removePlayer removes by id', () {
      controller.addPlayer('Alice');
      final id = controller.players.first.id;
      controller.removePlayer(id);
      expect(controller.players, isEmpty);
    });

    test('hasValidSetup is false with fewer than required players', () {
      // Default: 1 impostor, 0 mrWhite, needs 4 players (3 civilians + 1 impostor)
      controller.addPlayer('A');
      controller.addPlayer('B');
      controller.addPlayer('C');
      expect(controller.hasValidSetup, isFalse);
      controller.addPlayer('D');
      expect(controller.hasValidSetup, isTrue);
    });

    test('resetGame clears the players list', () {
      controller.addPlayer('Alice');
      controller.addPlayer('Bob');
      expect(controller.players.length, 2);
      controller.resetGame();
      expect(controller.players, isEmpty);
      expect(controller.currentState, GameState.lobby);
    });

    test('resetGame resets winner to none', () {
      controller.resetGame();
      expect(controller.winner, WinnerType.none);
    });

    test('updateImpostorCount clamps to valid range', () {
      // With 4 players and 3 min civilians, can have at most 1 impostor
      controller.addPlayer('A');
      controller.addPlayer('B');
      controller.addPlayer('C');
      controller.addPlayer('D');
      controller.updateImpostorCount(5);
      expect(controller.impostorCount, 1); // clamped to 1
    });

    test('completeOnboarding transitions to lobby', () {
      final c = GameController(initialState: GameState.onboarding);
      expect(c.currentState, GameState.onboarding);
      c.completeOnboarding();
      expect(c.currentState, GameState.lobby);
      c.dispose();
    });

    test('minPlayersRequired reflects impostor + mrWhite + minCivilians', () {
      expect(
        controller.minPlayersRequired,
        controller.impostorCount +
            controller.mrWhiteCount +
            GameController.minCivilians,
      );
    });

    test('players list is unmodifiable', () {
      controller.addPlayer('Alice');
      final list = controller.players;
      // List.unmodifiable — calling removeAt should throw UnsupportedError
      expect(() => list.removeAt(0), throwsUnsupportedError);
    });
  });
}
