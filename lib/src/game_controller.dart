import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'models/game_state.dart';
import 'models/player.dart';
import 'models/role.dart';
import 'models/word_pair.dart';
import 'monetization/monetization_controller.dart';

class GameController extends ChangeNotifier {
  GameState _currentState = GameState.onboarding;
  final List<Player> _players = [];
  WordPair? _currentWordPair;
  int _currentPlayerIndex = 0;
  List<int> _turnOrder = [];
  MonetizationController? _monetization;

  // Timer
  Timer? _discussionTimer;
  int _timeLeft = 240; // 4 minutes in seconds

  // Voting & Results

  String _winnerMessage = "";
  String _winner = ""; // 'citizens' or 'spy'

  // Game Settings
  int impostorCount = 1;
  int mrWhiteCount = 0;
  static const int minCivilians = 3;

  // Feedback State
  String? _lastEliminationMessage;
  Player? _lastEliminatedPlayer; // Track the actual player object
  bool _isRoleRevealed =
      false; // Track if the current player has revealed their role

  // Getters
  GameState get currentState => _currentState;
  List<Player> get players => List.unmodifiable(_players);
  WordPair? get currentWordPair => _currentWordPair;
  // Computed property for the secret word (civilian word)
  String get secretWord => _currentWordPair?.civilianWord ?? '?';
  int get currentPlayerIndex => _currentPlayerIndex;
  Player? get currentPlayer {
    if (_turnOrder.isEmpty || _currentPlayerIndex >= _turnOrder.length) {
      return null;
    }
    return _players[_turnOrder[_currentPlayerIndex]];
  }

  int get timeLeft => _timeLeft;
  String get winnerMessage => _winnerMessage;
  String get winner => _winner;
  String? get lastEliminationMessage => _lastEliminationMessage;
  Player? get lastEliminatedPlayer => _lastEliminatedPlayer;
  bool get isRoleRevealed => _isRoleRevealed;
  bool get hasMrWhite => mrWhiteCount > 0;
  int get minPlayersRequired => impostorCount + mrWhiteCount + minCivilians;
  bool get hasValidSetup => _players.length >= minPlayersRequired;

  void updateImpostorCount(int value, {int? playerCount}) {
    final count = playerCount ?? _players.length;
    final maxTotal = max(0, count - minCivilians);
    final maxImpostors = max(1, maxTotal - mrWhiteCount);
    impostorCount = value.clamp(1, maxImpostors);
    if (impostorCount + mrWhiteCount > maxTotal) {
      mrWhiteCount = max(0, maxTotal - impostorCount);
    }
    notifyListeners();
  }

  void updateMrWhiteCount(int value, {int? playerCount}) {
    final count = playerCount ?? _players.length;
    final maxTotal = max(0, count - minCivilians);
    final maxMrWhites = max(0, maxTotal - impostorCount);
    mrWhiteCount = value.clamp(0, maxMrWhites);
    notifyListeners();
  }

  // Fun Messages (Roasts)
  final List<String> _funFailureMessages = [
    "Oops! {name} was innocent. Your detective skills need work.",
    "You just eliminated {name}... a totally innocent civilian. Awkward.",
    "Congratulations! You helped the Impostor by voting out {name}.",
    "{name} was NOT the impostor. The Impostor is probably laughing right now.",
    "Wrong choice! {name} was one of you. Trust no one... especially yourselves.",
    "Another one bites the dust. Too bad {name} was on your team.",
    "Narrator: 'It was at this moment, they knew... they messed up.' ({name} was innocent)",
    "Swing and a miss! {name} was a civilian.",
  ];

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

    // Reset game state
    for (var player in _players) {
      player.resetForNewRound();
    }
    _currentPlayerIndex = 0;
    _winnerMessage = "";
    _winner = "";
    _isRoleRevealed = false; // Reset reveal state

    _assignRoles();
    _setupTurnOrder();

    _currentState = GameState.reveal;
    notifyListeners();
  }

  void _assignRoles() {
    final random = Random();
    int assignedImpostors = 0;
    int assignedMrWhites = 0;

    // Create a shuffled list of indices
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
      // Find a civilian to swap with
      for (int i = 1; i < _turnOrder.length; i++) {
        if (_players[_turnOrder[i]].role == Role.civilian) {
          // Swap
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

    // Ensure we start with a valid player
    while (_currentPlayerIndex < _players.length &&
        _players[_turnOrder[_currentPlayerIndex]].isEliminated) {
      _currentPlayerIndex++;
    }

    notifyListeners();
  }

  void nextTurn() {
    // Find next valid player index
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

  // Method called when user clicks "Reveal Role" on TurnScreen
  void revealRole() {
    _isRoleRevealed = true;
    notifyListeners();
  }

  // Method called when user clicks "Got it" on RevealScreen
  void endTurn() {
    nextPlayerReveal();
  }

  void nextPlayerReveal() {
    _isRoleRevealed = false; // Reset for next player
    if (_currentPlayerIndex < _players.length - 1) {
      _currentPlayerIndex++;
      notifyListeners();
    } else {
      proceedToTurnTaking();
    }
  }

  void startDiscussion() {
    _currentState = GameState.discussion;
    _timeLeft = 240; // 4 minutes
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
        startVoting(); // Auto start voting? Or just stop timer
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
    _lastEliminatedPlayer = player; // Store the player object

    // Check Win Conditions
    // Check Win Conditions
    final activePlayers = _players.where((p) => !p.isEliminated).toList();
    // Impostor Team = Impostors + Mr White
    final impostorTeam = activePlayers
        .where((p) => p.role == Role.impostor || p.role == Role.mrWhite)
        .toList();
    final civilians = activePlayers
        .where((p) => p.role == Role.civilian)
        .toList();

    if (impostorTeam.isEmpty) {
      // Civilians Win
      _currentState = GameState.results;
      _winner = "citizens";
      final eliminatedName = player.name; // The one just eliminated
      _winnerMessage =
          "Civilians Win! The hidden threat ($eliminatedName) was eliminated.";
    } else if (impostorTeam.length >= civilians.length) {
      // Impostor Team Wins
      _currentState = GameState.results;
      _winner = "spy";
      final teamNames = impostorTeam.map((p) => p.name).join(", ");
      _winnerMessage = "Impostors Win! ($teamNames) outlasted the civilians.";
    } else {
      // Game Continues - Show Feedback
      _lastEliminationMessage =
          _funFailureMessages[Random().nextInt(_funFailureMessages.length)]
              .replaceAll("{name}", player.name);

      _currentState = GameState.roundFeedback;
    }

    notifyListeners();
  }

  // Method to acknowledge feedback and move on
  void acknowledgeRoundFeedback() {
    _lastEliminationMessage = null;
    _lastEliminatedPlayer = null;
    proceedToTurnTaking();
  }

  // Alias for acknowledgeRoundFeedback to match UI calls if any
  void acknowledgeElimination() => acknowledgeRoundFeedback();

  void clearEliminationMessage() {
    _lastEliminationMessage = null;
    _lastEliminatedPlayer = null;
    notifyListeners();
  }

  void resetGame() {
    _discussionTimer?.cancel();
    _currentState = GameState.lobby;
    _currentWordPair = null;
    _lastEliminationMessage = null;
    _lastEliminatedPlayer = null;
    _isRoleRevealed = false;
    _winner = "";
    notifyListeners();
  }

  void completeOnboarding() {
    _currentState = GameState.lobby;
    notifyListeners();
  }
}
