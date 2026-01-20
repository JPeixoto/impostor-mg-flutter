// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get lobbyTitle => 'Lobby';

  @override
  String get waitingForPlayers => 'Waiting for players...';

  @override
  String get enterPlayerName => 'Enter player name';

  @override
  String get startGame => 'Start Game';

  @override
  String get dailyWords => 'Daily Words';

  @override
  String get dailyLimitReached => 'Daily limit reached.';

  @override
  String freeRoundsRemaining(int count) {
    return '$count free rounds remaining.';
  }

  @override
  String get premiumActive => 'Premium Active. Unlimited words.';

  @override
  String get mrWhite => 'Mr. White';

  @override
  String get mrWhiteDescription => 'Adds an impostor who knows nothing';

  @override
  String get watchAd => 'Watch ad (+4 rounds)';

  @override
  String get getUnlimited => 'Get Unlimited';

  @override
  String passThePhone(String name) {
    return 'Pass the phone to $name';
  }

  @override
  String get tapToReveal => 'Tap to reveal role';

  @override
  String get youAre => 'You are';

  @override
  String get civilian => 'Civilian';

  @override
  String get spy => 'Spy';

  @override
  String get secretWord => 'Secret Word';

  @override
  String get unknown => 'Unknown';

  @override
  String get doneNextPlayer => 'Done, Next Player';

  @override
  String get timeLeft => 'Time Left';

  @override
  String get timeToDiscuss => 'Time to discuss';

  @override
  String get castYourVote => 'Cast your vote';

  @override
  String get whosTheSpy => 'Who is the Spy?';

  @override
  String get voteToEliminate => 'Vote to eliminate';

  @override
  String get civilianWin => 'Civilians Win!';

  @override
  String get spyWin => 'Spy Wins!';

  @override
  String get playAgain => 'Play Again';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String theSpyWas(String name) {
    return 'The Spy was $name';
  }

  @override
  String mrWhiteWas(String name) {
    return 'Mr. White was $name';
  }

  @override
  String wordWas(String word) {
    return 'The word was $word';
  }

  @override
  String get needMoreWords => 'Need more words?';

  @override
  String get watchAdOrPass =>
      'Watch a short ad to get +4 rounds or get the 24h pass for unlimited play.';

  @override
  String get notNow => 'Not now';

  @override
  String getPass(String price) {
    return 'Get Unlimited ($price)';
  }

  @override
  String get yourTurn => 'Your Turn';

  @override
  String itsNamesTurn(String name) {
    return 'It\'s $name\'s Turn';
  }

  @override
  String passToName(String name) {
    return 'Pass to $name';
  }

  @override
  String get askQuestion => 'Ask a question to another player.';

  @override
  String get dontLetOthersSee => 'Don\'t let others see the screen!';

  @override
  String get askYesNoQuestion => 'Ask a yes/no question';

  @override
  String get tapDoneWhenFinished => 'Tap Done when finished';

  @override
  String get keepScreenHidden => 'Keep the screen hidden';

  @override
  String get tapRevealWhenReady => 'Tap \"Reveal Role\" when ready';

  @override
  String iAmNameRevealRole(String name) {
    return 'I am $name, Reveal Role';
  }

  @override
  String get yourRole => 'Your Role';

  @override
  String get youAreTheImpostor => 'YOU ARE THE IMPOSTOR';

  @override
  String get youAreACitizen => 'YOU ARE A CITIZEN';

  @override
  String get blendIn => 'Blend In';

  @override
  String get impostorInstruction =>
      'You don\'t know the secret word.\nListen carefully and fake it!';

  @override
  String get theSecretWord => 'The Secret Word';

  @override
  String get dontBeTooObvious => 'Don\'t be too obvious!';

  @override
  String get nextUp => 'Next Up';

  @override
  String get passDeviceInstruction => 'Pass the device to the next player';

  @override
  String get gotIt => 'Got it!';

  @override
  String get busted => 'Busted!';

  @override
  String get innocent => 'Innocent!';

  @override
  String get youCaughtTheImpostor => 'You caught the Impostor!';

  @override
  String get youVotedOutInnocent => 'You voted out an innocent citizen...';

  @override
  String get continueGame => 'Continue';

  @override
  String get spyEvadedDetection => 'The spy evaded detection.';

  @override
  String get hiddenThreatEliminated => 'The hidden threat has been eliminated.';

  @override
  String get secretWordWas => 'The secret word was';

  @override
  String get discussionRoom => 'Discussion Room';

  @override
  String get votingBooth => 'Voting Booth';

  @override
  String get discuss => 'DISCUSS';

  @override
  String get vote => 'VOTE';

  @override
  String get shareHints => 'Share hints. Clock is ticking.';

  @override
  String get pickWhoToEliminate => 'Pick who to eliminate';

  @override
  String get remaining => 'remaining';

  @override
  String get tradeHints => 'Trade hints, note every slip.';

  @override
  String get tapToVoteOut => 'Tap to vote out';

  @override
  String get callAVote => 'Call a vote';

  @override
  String get results => 'Results';

  @override
  String get onboardingAppName => 'IMPOSTOR PARTY';

  @override
  String get onboardingTagline => 'Pass-and-play deception.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingSkipTutorial => 'Skip tutorial';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStartGame => 'Start Game';

  @override
  String get onboardingTitle1 => 'Welcome Agent';

  @override
  String get onboardingDesc1 =>
      'In a room full of civilians, someone is hiding a secret. Can you uncover the truth?';

  @override
  String get onboardingTitle2 => 'Civilian vs Impostor';

  @override
  String get onboardingDesc2 =>
      'Civilians share a secret word. The Impostor has a different one but must blend in.';

  @override
  String get onboardingTitle3 => 'Trust No One';

  @override
  String get onboardingDesc3 =>
      'Discuss, vote, and eliminate the Impostor before it\'s too late.';

  @override
  String get onboardingChip1 => 'Fast rounds';

  @override
  String get onboardingChip2 => 'Bluff & deduce';

  @override
  String get onboardingChip3 => 'Pass-and-play';
}
