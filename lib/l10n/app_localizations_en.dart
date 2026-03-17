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
  String get players => 'Players';

  @override
  String get settings => 'Settings';

  @override
  String get settingsComingSoon => 'Settings screen coming soon.';

  @override
  String get settingsTitle => 'Game Settings';

  @override
  String get impostorsLabel => 'Impostors (different word)';

  @override
  String get mrWhiteLabel => 'Mr. White (no word)';

  @override
  String get impostorsShort => 'Impostors';

  @override
  String get mrWhiteShort => 'Mr White';

  @override
  String minPlayersRule(int count) {
    return 'Need at least $count civilians.';
  }

  @override
  String maxSpecialRoles(int players, int count) {
    return 'With $players players, max liars: $count.';
  }

  @override
  String get invalidSetupWarning => 'Add more players or reduce liars to start.';

  @override
  String get hideRolesWhenMrWhiteLabel => 'Hide role identity';

  @override
  String get hideRolesWhenMrWhiteHint => 'If enabled, players see only word clues and do not see their exact role.';

  @override
  String get done => 'Done';

  @override
  String needPlayersToStart(int count) {
    return 'Add at least $count players to start.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get leaveGameTitle => 'Return to lobby?';

  @override
  String get leaveGameMessage => 'This will end the current round.';

  @override
  String get waitingForPlayers => 'Add at least 3 players to start.';

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
  String get mrWhiteDescription => 'You get no word.\nListen carefully and bluff.';

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
  String get spy => 'Impostor';

  @override
  String get secretWord => 'Secret Word';

  @override
  String get yourWord => 'Your Word';

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
  String get whosTheSpy => 'Who\'s suspicious?';

  @override
  String get voteToEliminate => 'Vote to eliminate';

  @override
  String get civilianWin => 'Civilians Win!';

  @override
  String get spyWin => 'Liars Win!';

  @override
  String get playAgain => 'Play Again';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get premium => 'Premium';

  @override
  String get unlimited => 'Unlimited';

  @override
  String get roundsLeft => 'Rounds left';

  @override
  String theSpyWas(String name) {
    return 'The Impostor was $name';
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
  String get watchAdOrPass => 'Watch a short ad to get +4 rounds or get the 24h pass for unlimited play.';

  @override
  String get dayPassFallback => '24h pass';

  @override
  String get adNotCompletedTryAgain => 'Ad was not completed. Try again.';

  @override
  String get purchaseStreamError => 'Purchase service is unavailable right now. Try again.';

  @override
  String get purchaseStoreUnavailable => 'Store is unavailable. Try again later.';

  @override
  String get purchaseStartFailed => 'Unable to start purchase. Try again.';

  @override
  String get purchaseFailed => 'Purchase failed.';

  @override
  String get purchaseCanceled => 'Purchase canceled.';

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
  String get askYesNoQuestion => 'Say a word or expression';

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
  String get impostorInstruction => 'Your word is different from the civilians\'.\nBlend in without giving yourself away!';

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
  String get youCaughtTheImpostor => 'You caught a liar!';

  @override
  String get youVotedOutInnocent => 'You voted out an innocent citizen...';

  @override
  String get continueGame => 'Continue';

  @override
  String get spyEvadedDetection => 'The liars evaded detection.';

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
  String get onboardingAppName => 'SOMEONE IS LYING';

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
  String get onboardingDesc1 => 'In a room full of civilians, someone is hiding a secret. Can you uncover the truth?';

  @override
  String get onboardingTitle2 => 'Civilian vs Impostor';

  @override
  String get onboardingDesc2 => 'Civilians share a secret word. The Impostor gets a different word. Mr White gets no word and must bluff.';

  @override
  String get onboardingTitle3 => 'Trust No One';

  @override
  String get onboardingDesc3 => 'Discuss, vote, and eliminate the liars before it\'s too late.';

  @override
  String get onboardingChip1 => 'Fast rounds';

  @override
  String get onboardingChip2 => 'Bluff & deduce';

  @override
  String get onboardingChip3 => 'Pass-and-play';


  @override
  String funFail0(String name) {
    return 'Oops! $name was innocent. Your detective skills need work.';
  }

  @override
  String funFail1(String name) {
    return 'You just eliminated $name... a totally innocent civilian. Awkward.';
  }

  @override
  String funFail2(String name) {
    return 'Congratulations! You helped the liars by voting out $name.';
  }

  @override
  String funFail3(String name) {
    return '$name was NOT a liar. The liars are probably laughing right now.';
  }

  @override
  String funFail4(String name) {
    return 'Wrong choice! $name was on your team. Trust no one… especially yourselves.';
  }

  @override
  String funFail5(String name) {
    return 'Another one bites the dust. Too bad $name was on your team.';
  }

  @override
  String funFail6(String name) {
    return 'It was at this moment they knew… they messed up. ($name was innocent)';
  }

  @override
  String funFail7(String name) {
    return 'Swing and a miss! $name was a civilian.';
  }

  @override
  String winCiviliansMessage(String name) {
    return 'Civilians Win! The hidden threat ($name) was eliminated.';
  }

  @override
  String winImpostorsMessage(String names) {
    return 'Liars Win! ($names) outlasted the civilians.';
  }
}
