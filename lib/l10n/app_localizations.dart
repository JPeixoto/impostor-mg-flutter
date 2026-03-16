import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @lobbyTitle.
  ///
  /// In en, this message translates to:
  /// **'Lobby'**
  String get lobbyTitle;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Settings screen coming soon.'**
  String get settingsComingSoon;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Game Settings'**
  String get settingsTitle;

  /// No description provided for @impostorsLabel.
  ///
  /// In en, this message translates to:
  /// **'Impostors (no word)'**
  String get impostorsLabel;

  /// No description provided for @mrWhiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Mr. White'**
  String get mrWhiteLabel;

  /// No description provided for @impostorsShort.
  ///
  /// In en, this message translates to:
  /// **'Impostors'**
  String get impostorsShort;

  /// No description provided for @mrWhiteShort.
  ///
  /// In en, this message translates to:
  /// **'Mr White'**
  String get mrWhiteShort;

  /// No description provided for @minPlayersRule.
  ///
  /// In en, this message translates to:
  /// **'Need at least {count} civilians.'**
  String minPlayersRule(int count);

  /// No description provided for @maxSpecialRoles.
  ///
  /// In en, this message translates to:
  /// **'With {players} players, max special roles: {count}.'**
  String maxSpecialRoles(int players, int count);

  /// No description provided for @invalidSetupWarning.
  ///
  /// In en, this message translates to:
  /// **'Add more players or reduce special roles to start.'**
  String get invalidSetupWarning;

  /// No description provided for @hideRolesWhenMrWhiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Hide role labels with Mr White'**
  String get hideRolesWhenMrWhiteLabel;

  /// No description provided for @hideRolesWhenMrWhiteHint.
  ///
  /// In en, this message translates to:
  /// **'If enabled, role labels are hidden whenever Mr White is included in the round.'**
  String get hideRolesWhenMrWhiteHint;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @needPlayersToStart.
  ///
  /// In en, this message translates to:
  /// **'Add at least {count} players to start.'**
  String needPlayersToStart(int count);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @leaveGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Return to lobby?'**
  String get leaveGameTitle;

  /// No description provided for @leaveGameMessage.
  ///
  /// In en, this message translates to:
  /// **'This will end the current round.'**
  String get leaveGameMessage;

  /// No description provided for @waitingForPlayers.
  ///
  /// In en, this message translates to:
  /// **'Add at least 3 players to start.'**
  String get waitingForPlayers;

  /// No description provided for @enterPlayerName.
  ///
  /// In en, this message translates to:
  /// **'Enter player name'**
  String get enterPlayerName;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// No description provided for @dailyWords.
  ///
  /// In en, this message translates to:
  /// **'Daily Words'**
  String get dailyWords;

  /// No description provided for @dailyLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Daily limit reached.'**
  String get dailyLimitReached;

  /// No description provided for @freeRoundsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} free rounds remaining.'**
  String freeRoundsRemaining(int count);

  /// No description provided for @premiumActive.
  ///
  /// In en, this message translates to:
  /// **'Premium Active. Unlimited words.'**
  String get premiumActive;

  /// No description provided for @mrWhite.
  ///
  /// In en, this message translates to:
  /// **'Mr. White'**
  String get mrWhite;

  /// No description provided for @mrWhiteDescription.
  ///
  /// In en, this message translates to:
  /// **'Adds an impostor who knows nothing'**
  String get mrWhiteDescription;

  /// No description provided for @watchAd.
  ///
  /// In en, this message translates to:
  /// **'Watch ad (+4 rounds)'**
  String get watchAd;

  /// No description provided for @getUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Get Unlimited'**
  String get getUnlimited;

  /// No description provided for @passThePhone.
  ///
  /// In en, this message translates to:
  /// **'Pass the phone to {name}'**
  String passThePhone(String name);

  /// No description provided for @tapToReveal.
  ///
  /// In en, this message translates to:
  /// **'Tap to reveal role'**
  String get tapToReveal;

  /// No description provided for @youAre.
  ///
  /// In en, this message translates to:
  /// **'You are'**
  String get youAre;

  /// No description provided for @civilian.
  ///
  /// In en, this message translates to:
  /// **'Civilian'**
  String get civilian;

  /// No description provided for @spy.
  ///
  /// In en, this message translates to:
  /// **'Impostor'**
  String get spy;

  /// No description provided for @secretWord.
  ///
  /// In en, this message translates to:
  /// **'Secret Word'**
  String get secretWord;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @doneNextPlayer.
  ///
  /// In en, this message translates to:
  /// **'Done, Next Player'**
  String get doneNextPlayer;

  /// No description provided for @timeLeft.
  ///
  /// In en, this message translates to:
  /// **'Time Left'**
  String get timeLeft;

  /// No description provided for @timeToDiscuss.
  ///
  /// In en, this message translates to:
  /// **'Time to discuss'**
  String get timeToDiscuss;

  /// No description provided for @castYourVote.
  ///
  /// In en, this message translates to:
  /// **'Cast your vote'**
  String get castYourVote;

  /// No description provided for @whosTheSpy.
  ///
  /// In en, this message translates to:
  /// **'Who\'s the Impostor?'**
  String get whosTheSpy;

  /// No description provided for @voteToEliminate.
  ///
  /// In en, this message translates to:
  /// **'Vote to eliminate'**
  String get voteToEliminate;

  /// No description provided for @civilianWin.
  ///
  /// In en, this message translates to:
  /// **'Civilians Win!'**
  String get civilianWin;

  /// No description provided for @spyWin.
  ///
  /// In en, this message translates to:
  /// **'Impostor Wins!'**
  String get spyWin;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @backToLobby.
  ///
  /// In en, this message translates to:
  /// **'Back to Lobby'**
  String get backToLobby;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @roundsLeft.
  ///
  /// In en, this message translates to:
  /// **'Rounds left'**
  String get roundsLeft;

  /// No description provided for @theSpyWas.
  ///
  /// In en, this message translates to:
  /// **'The Impostor was {name}'**
  String theSpyWas(String name);

  /// No description provided for @mrWhiteWas.
  ///
  /// In en, this message translates to:
  /// **'Mr. White was {name}'**
  String mrWhiteWas(String name);

  /// No description provided for @wordWas.
  ///
  /// In en, this message translates to:
  /// **'The word was {word}'**
  String wordWas(String word);

  /// No description provided for @needMoreWords.
  ///
  /// In en, this message translates to:
  /// **'Need more words?'**
  String get needMoreWords;

  /// No description provided for @watchAdOrPass.
  ///
  /// In en, this message translates to:
  /// **'Watch a short ad to get +4 rounds or get the 24h pass for unlimited play.'**
  String get watchAdOrPass;

  /// No description provided for @dayPassFallback.
  ///
  /// In en, this message translates to:
  /// **'24h pass'**
  String get dayPassFallback;

  /// No description provided for @adNotCompletedTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Ad was not completed. Try again.'**
  String get adNotCompletedTryAgain;

  /// No description provided for @purchaseStreamError.
  ///
  /// In en, this message translates to:
  /// **'Purchase service is unavailable right now. Try again.'**
  String get purchaseStreamError;

  /// No description provided for @purchaseStoreUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Store is unavailable. Try again later.'**
  String get purchaseStoreUnavailable;

  /// No description provided for @purchaseStartFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to start purchase. Try again.'**
  String get purchaseStartFailed;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed.'**
  String get purchaseFailed;

  /// No description provided for @purchaseCanceled.
  ///
  /// In en, this message translates to:
  /// **'Purchase canceled.'**
  String get purchaseCanceled;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @getPass.
  ///
  /// In en, this message translates to:
  /// **'Get Unlimited ({price})'**
  String getPass(String price);

  /// No description provided for @yourTurn.
  ///
  /// In en, this message translates to:
  /// **'Your Turn'**
  String get yourTurn;

  /// No description provided for @itsNamesTurn.
  ///
  /// In en, this message translates to:
  /// **'It\'s {name}\'s Turn'**
  String itsNamesTurn(String name);

  /// No description provided for @passToName.
  ///
  /// In en, this message translates to:
  /// **'Pass to {name}'**
  String passToName(String name);

  /// No description provided for @askQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask a question to another player.'**
  String get askQuestion;

  /// No description provided for @dontLetOthersSee.
  ///
  /// In en, this message translates to:
  /// **'Don\'t let others see the screen!'**
  String get dontLetOthersSee;

  /// No description provided for @askYesNoQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask a yes/no question'**
  String get askYesNoQuestion;

  /// No description provided for @tapDoneWhenFinished.
  ///
  /// In en, this message translates to:
  /// **'Tap Done when finished'**
  String get tapDoneWhenFinished;

  /// No description provided for @keepScreenHidden.
  ///
  /// In en, this message translates to:
  /// **'Keep the screen hidden'**
  String get keepScreenHidden;

  /// No description provided for @tapRevealWhenReady.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Reveal Role\" when ready'**
  String get tapRevealWhenReady;

  /// No description provided for @iAmNameRevealRole.
  ///
  /// In en, this message translates to:
  /// **'I am {name}, Reveal Role'**
  String iAmNameRevealRole(String name);

  /// No description provided for @yourRole.
  ///
  /// In en, this message translates to:
  /// **'Your Role'**
  String get yourRole;

  /// No description provided for @youAreTheImpostor.
  ///
  /// In en, this message translates to:
  /// **'YOU ARE THE IMPOSTOR'**
  String get youAreTheImpostor;

  /// No description provided for @youAreACitizen.
  ///
  /// In en, this message translates to:
  /// **'YOU ARE A CITIZEN'**
  String get youAreACitizen;

  /// No description provided for @blendIn.
  ///
  /// In en, this message translates to:
  /// **'Blend In'**
  String get blendIn;

  /// No description provided for @impostorInstruction.
  ///
  /// In en, this message translates to:
  /// **'You don\'t know the secret word.\nListen carefully and fake it!'**
  String get impostorInstruction;

  /// No description provided for @theSecretWord.
  ///
  /// In en, this message translates to:
  /// **'The Secret Word'**
  String get theSecretWord;

  /// No description provided for @dontBeTooObvious.
  ///
  /// In en, this message translates to:
  /// **'Don\'t be too obvious!'**
  String get dontBeTooObvious;

  /// No description provided for @nextUp.
  ///
  /// In en, this message translates to:
  /// **'Next Up'**
  String get nextUp;

  /// No description provided for @passDeviceInstruction.
  ///
  /// In en, this message translates to:
  /// **'Pass the device to the next player'**
  String get passDeviceInstruction;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get gotIt;

  /// No description provided for @busted.
  ///
  /// In en, this message translates to:
  /// **'Busted!'**
  String get busted;

  /// No description provided for @innocent.
  ///
  /// In en, this message translates to:
  /// **'Innocent!'**
  String get innocent;

  /// No description provided for @youCaughtTheImpostor.
  ///
  /// In en, this message translates to:
  /// **'You caught the Impostor!'**
  String get youCaughtTheImpostor;

  /// No description provided for @youVotedOutInnocent.
  ///
  /// In en, this message translates to:
  /// **'You voted out an innocent citizen...'**
  String get youVotedOutInnocent;

  /// No description provided for @continueGame.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueGame;

  /// No description provided for @spyEvadedDetection.
  ///
  /// In en, this message translates to:
  /// **'The impostor evaded detection.'**
  String get spyEvadedDetection;

  /// No description provided for @hiddenThreatEliminated.
  ///
  /// In en, this message translates to:
  /// **'The hidden threat has been eliminated.'**
  String get hiddenThreatEliminated;

  /// No description provided for @secretWordWas.
  ///
  /// In en, this message translates to:
  /// **'The secret word was'**
  String get secretWordWas;

  /// No description provided for @discussionRoom.
  ///
  /// In en, this message translates to:
  /// **'Discussion Room'**
  String get discussionRoom;

  /// No description provided for @votingBooth.
  ///
  /// In en, this message translates to:
  /// **'Voting Booth'**
  String get votingBooth;

  /// No description provided for @discuss.
  ///
  /// In en, this message translates to:
  /// **'DISCUSS'**
  String get discuss;

  /// No description provided for @vote.
  ///
  /// In en, this message translates to:
  /// **'VOTE'**
  String get vote;

  /// No description provided for @shareHints.
  ///
  /// In en, this message translates to:
  /// **'Share hints. Clock is ticking.'**
  String get shareHints;

  /// No description provided for @pickWhoToEliminate.
  ///
  /// In en, this message translates to:
  /// **'Pick who to eliminate'**
  String get pickWhoToEliminate;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remaining;

  /// No description provided for @tradeHints.
  ///
  /// In en, this message translates to:
  /// **'Trade hints, note every slip.'**
  String get tradeHints;

  /// No description provided for @tapToVoteOut.
  ///
  /// In en, this message translates to:
  /// **'Tap to vote out'**
  String get tapToVoteOut;

  /// No description provided for @callAVote.
  ///
  /// In en, this message translates to:
  /// **'Call a vote'**
  String get callAVote;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @onboardingAppName.
  ///
  /// In en, this message translates to:
  /// **'IMPOSTOR PARTY'**
  String get onboardingAppName;

  /// No description provided for @onboardingTagline.
  ///
  /// In en, this message translates to:
  /// **'Pass-and-play deception.'**
  String get onboardingTagline;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingSkipTutorial.
  ///
  /// In en, this message translates to:
  /// **'Skip tutorial'**
  String get onboardingSkipTutorial;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStartGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get onboardingStartGame;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome Agent'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'In a room full of civilians, someone is hiding a secret. Can you uncover the truth?'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Civilian vs Impostor'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Civilians share a secret word. The Impostor doesn\'t know it. Mr White knows nothing and must bluff.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Trust No One'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Discuss, vote, and eliminate the Impostor before it\'s too late.'**
  String get onboardingDesc3;

  /// No description provided for @onboardingChip1.
  ///
  /// In en, this message translates to:
  /// **'Fast rounds'**
  String get onboardingChip1;

  /// No description provided for @onboardingChip2.
  ///
  /// In en, this message translates to:
  /// **'Bluff & deduce'**
  String get onboardingChip2;

  /// No description provided for @onboardingChip3.
  ///
  /// In en, this message translates to:
  /// **'Pass-and-play'**
  String get onboardingChip3;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @funFail0.
  ///
  /// In en, this message translates to:
  /// **'Oops! {name} was innocent. Your detective skills need work.'**
  String funFail0(String name);

  /// No description provided for @funFail1.
  ///
  /// In en, this message translates to:
  /// **'You just eliminated {name}... a totally innocent civilian. Awkward.'**
  String funFail1(String name);

  /// No description provided for @funFail2.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You helped the Impostor by voting out {name}.'**
  String funFail2(String name);

  /// No description provided for @funFail3.
  ///
  /// In en, this message translates to:
  /// **'{name} was NOT the impostor. The Impostor is probably laughing right now.'**
  String funFail3(String name);

  /// No description provided for @funFail4.
  ///
  /// In en, this message translates to:
  /// **'Wrong choice! {name} was on your team. Trust no one… especially yourselves.'**
  String funFail4(String name);

  /// No description provided for @funFail5.
  ///
  /// In en, this message translates to:
  /// **'Another one bites the dust. Too bad {name} was on your team.'**
  String funFail5(String name);

  /// No description provided for @funFail6.
  ///
  /// In en, this message translates to:
  /// **'It was at this moment they knew… they messed up. ({name} was innocent)'**
  String funFail6(String name);

  /// No description provided for @funFail7.
  ///
  /// In en, this message translates to:
  /// **'Swing and a miss! {name} was a civilian.'**
  String funFail7(String name);

  /// No description provided for @winCiviliansMessage.
  ///
  /// In en, this message translates to:
  /// **'Civilians Win! The hidden threat ({name}) was eliminated.'**
  String winCiviliansMessage(String name);

  /// No description provided for @winImpostorsMessage.
  ///
  /// In en, this message translates to:
  /// **'Impostors Win! ({names}) outlasted the civilians.'**
  String winImpostorsMessage(String names);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
