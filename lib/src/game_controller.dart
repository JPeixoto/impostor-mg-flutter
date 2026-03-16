import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'models/game_state.dart';
import 'models/player.dart';
import 'models/role.dart';
import 'models/winner_type.dart';
import 'models/word_pair.dart';
import 'monetization/monetization_controller.dart';

class GameController extends ChangeNotifier {
  GameController({GameState initialState = GameState.onboarding})
    : _currentState = initialState;

  GameState _currentState;
  final List<Player> _players = [];
  WordPair? _currentWordPair;
  int _currentPlayerIndex = 0;
  List<int> _turnOrder = [];
  MonetizationController? _monetization;

  // Timer
  Timer? _discussionTimer;
  int _timeLeft = 240; // 4 minutes in seconds

  // Voting & Results
  WinnerType _winner = WinnerType.none;

  // Game Settings
  int impostorCount = 1;
  int mrWhiteCount = 0;
  bool _hideRoleIdentity = true;
  static const int minCivilians = 3;

  // Feedback State
  int? _lastEliminationMessageVariant;
  Player? _lastEliminatedPlayer;
  bool _isRoleRevealed = false;

  // Getters
  GameState get currentState => _currentState;
  List<Player> get players => List.unmodifiable(_players);
  WordPair? get currentWordPair => _currentWordPair;
  String get secretWord => _currentWordPair?.civilianWord ?? '?';
  int get currentPlayerIndex => _currentPlayerIndex;
  Player? get currentPlayer {
    if (_turnOrder.isEmpty || _currentPlayerIndex >= _turnOrder.length) {
      return null;
    }
    return _players[_turnOrder[_currentPlayerIndex]];
  }

  int get timeLeft => _timeLeft;
  WinnerType get winner => _winner;
  int? get lastEliminationMessageVariant => _lastEliminationMessageVariant;
  Player? get lastEliminatedPlayer => _lastEliminatedPlayer;
  bool get isRoleRevealed => _isRoleRevealed;
  bool get hideRoleIdentity => _hideRoleIdentity;
  int get minPlayersRequired => impostorCount + mrWhiteCount + minCivilians;
  bool get hasValidSetup => _players.length >= minPlayersRequired;

  String? wordForRole(Role? role, {WordPair? wordPair}) {
    final pair = wordPair ?? _currentWordPair;
    if (role == null || pair == null) return null;

    switch (role) {
      case Role.civilian:
        return pair.civilianWord;
      case Role.impostor:
        return pair.impostorWord;
      case Role.mrWhite:
        return null;
    }
  }

  void updateImpostorCount(int value, {int? playerCount}) {
    final count = playerCount ?? _players.length;
    final maxTotal = max(0, count - minCivilians);
    final effectiveMaxTotal = max(1, maxTotal);

    impostorCount = value.clamp(0, effectiveMaxTotal);

    if (impostorCount == 0 && mrWhiteCount == 0) {
      mrWhiteCount = 1;
    } else if (impostorCount + mrWhiteCount > effectiveMaxTotal) {
      mrWhiteCount = max(0, effectiveMaxTotal - impostorCount);
    }
    notifyListeners();
  }

  void updateMrWhiteCount(int value, {int? playerCount}) {
    final count = playerCount ?? _players.length;
    final maxTotal = max(0, count - minCivilians);
    final effectiveMaxTotal = max(1, maxTotal);

    mrWhiteCount = value.clamp(0, effectiveMaxTotal);

    if (mrWhiteCount == 0 && impostorCount == 0) {
      impostorCount = 1;
    } else if (impostorCount + mrWhiteCount > effectiveMaxTotal) {
      impostorCount = max(0, effectiveMaxTotal - mrWhiteCount);
    }
    notifyListeners();
  }

  void updateHideRoleIdentity(bool value) {
    if (_hideRoleIdentity == value) return;
    _hideRoleIdentity = value;
    notifyListeners();
  }

  void updateMonetization(MonetizationController monetization) {
    _monetization = monetization;
  }

  void addPlayer(String name) {
    _players.add(Player(name: name));
    notifyListeners();
  }

  void removePlayer(String id) {
    _players.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void startGame(BuildContext context) {
    if (!hasValidSetup) {
      return;
    }

    // Check quota
    if (_monetization != null && !_monetization!.canPlay) {
      // Should handle this in UI, but safety check here
      return;
    }

    // Pick Word First
    if (!_pickWord(Localizations.localeOf(context))) {
      return; // Failed to get word
    }

    // Consume Quota
    if (_monetization != null && _currentWordPair != null) {
      _monetization!.consumeWord(_currentWordPair!.id);
    }

    // Reset game state (preserve players list)
    for (var player in _players) {
      player.resetForNewRound();
    }
    _currentPlayerIndex = 0;
    _winner = WinnerType.none;
    _lastEliminationMessageVariant = null;
    _lastEliminatedPlayer = null;
    _isRoleRevealed = false;

    _assignRoles();
    _setupTurnOrder();

    _currentState = GameState.reveal;
    notifyListeners();
  }

  void _assignRoles() {
    final random = Random();
    int assignedImpostors = 0;
    int assignedMrWhites = 0;

    List<int> indices = List.generate(_players.length, (i) => i)
      ..shuffle(random);

    for (var i in indices) {
      if (assignedImpostors < impostorCount) {
        _players[i].role = Role.impostor;
        assignedImpostors++;
      } else if (assignedMrWhites < mrWhiteCount) {
        _players[i].role = Role.mrWhite;
        assignedMrWhites++;
      } else {
        _players[i].role = Role.civilian;
      }
    }
  }

  void _setupTurnOrder() {
    _turnOrder = List.generate(_players.length, (i) => i)..shuffle();

    // Ensure safe start: first player must know the word (civilian).
    if (_players[_turnOrder[0]].role != Role.civilian) {
      for (int i = 1; i < _turnOrder.length; i++) {
        if (_players[_turnOrder[i]].role == Role.civilian) {
          int temp = _turnOrder[0];
          _turnOrder[0] = _turnOrder[i];
          _turnOrder[i] = temp;
          break;
        }
      }
    }
  }

  bool _pickWord(Locale locale) {
    if (_monetization == null) return false;
    final word = _monetization!.getNextWord(locale);
    if (word == null) return false;

    _currentWordPair = word;
    return true;
  }

  void proceedToTurnTaking() {
    _currentState = GameState.turnTaking;
    _currentPlayerIndex = 0;

    while (_currentPlayerIndex < _players.length &&
        _players[_turnOrder[_currentPlayerIndex]].isEliminated) {
      _currentPlayerIndex++;
    }

    notifyListeners();
  }

  void nextTurn() {
    int nextIndex = _currentPlayerIndex + 1;
    while (nextIndex < _players.length &&
        _players[_turnOrder[nextIndex]].isEliminated) {
      nextIndex++;
    }

    if (nextIndex < _players.length) {
      _currentPlayerIndex = nextIndex;
      notifyListeners();
    } else {
      startDiscussion();
    }
  }

  void revealRole() {
    _isRoleRevealed = true;
    notifyListeners();
  }

  void nextPlayerReveal() {
    _isRoleRevealed = false;
    if (_currentPlayerIndex < _players.length - 1) {
      _currentPlayerIndex++;
      notifyListeners();
    } else {
      proceedToTurnTaking();
    }
  }

  void startDiscussion() {
    _currentState = GameState.discussion;
    _timeLeft = 240;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _discussionTimer?.cancel();
    _discussionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        timer.cancel();
        startVoting();
      }
    });
  }

  void startVoting() {
    _discussionTimer?.cancel();
    _currentState = GameState.voting;
    notifyListeners();
  }

  void eliminatePlayer(Player player) {
    player.isEliminated = true;
    _lastEliminatedPlayer = player;

    // Check Win Conditions
    final activePlayers = _players.where((p) => !p.isEliminated).toList();
    final impostorTeam = activePlayers
        .where((p) => p.role == Role.impostor || p.role == Role.mrWhite)
        .toList();
    final civilians = activePlayers
        .where((p) => p.role == Role.civilian)
        .toList();

    if (impostorTeam.isEmpty) {
      // Civilians Win
      _currentState = GameState.results;
      _winner = WinnerType.citizens;
      _lastEliminationMessageVariant = null;
    } else if (impostorTeam.length >= civilians.length) {
      // Impostor Team Wins
      _currentState = GameState.results;
      _winner = WinnerType.spy;
      _lastEliminationMessageVariant = null;
    } else {
      // Game continues: store only variant; localize in the UI at render time.
      _lastEliminationMessageVariant = Random().nextInt(8);
      _currentState = GameState.roundFeedback;
    }

    notifyListeners();
  }

  void acknowledgeRoundFeedback() {
    _lastEliminationMessageVariant = null;
    _lastEliminatedPlayer = null;
    proceedToTurnTaking();
  }

  void acknowledgeElimination() => acknowledgeRoundFeedback();

  void resetGame() {
    _discussionTimer?.cancel();
    _currentState = GameState.lobby;
    for (var player in _players) {
      player.resetForNewRound();
    }
    _currentPlayerIndex = 0;
    _turnOrder = [];
    _currentWordPair = null;
    _lastEliminationMessageVariant = null;
    _lastEliminatedPlayer = null;
    _isRoleRevealed = false;
    _winner = WinnerType.none;
    notifyListeners();
  }

  void completeOnboarding() {
    _currentState = GameState.lobby;
    notifyListeners();
  }

  void openOnboarding() {
    _currentState = GameState.onboarding;
    notifyListeners();
  }

  @override
  void dispose() {
    _discussionTimer?.cancel();
    super.dispose();
  }
}
