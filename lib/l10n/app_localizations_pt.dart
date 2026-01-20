// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get lobbyTitle => 'Lobby';

  @override
  String get waitingForPlayers => 'À espera de jogadores...';

  @override
  String get enterPlayerName => 'Insira o nome';

  @override
  String get startGame => 'Iniciar Jogo';

  @override
  String get dailyWords => 'Palavras Diárias';

  @override
  String get dailyLimitReached => 'Limite diário atingido.';

  @override
  String freeRoundsRemaining(int count) {
    return '$count rondas gratuitas.';
  }

  @override
  String get premiumActive => 'Premium Ativo. Palavras ilimitadas.';

  @override
  String get mrWhite => 'Mr. White';

  @override
  String get mrWhiteDescription => 'Adiciona um impostor que não sabe nada';

  @override
  String get watchAd => 'Ver anúncio (+4 rondas)';

  @override
  String get getUnlimited => 'Obter Ilimitado';

  @override
  String passThePhone(String name) {
    return 'Passa o telemóvel a $name';
  }

  @override
  String get tapToReveal => 'Toca para revelar';

  @override
  String get youAre => 'Tu és';

  @override
  String get civilian => 'Civil';

  @override
  String get spy => 'Espião';

  @override
  String get secretWord => 'Palavra Secreta';

  @override
  String get unknown => 'Desconhecido';

  @override
  String get doneNextPlayer => 'Feito, Próximo';

  @override
  String get timeLeft => 'Tempo Restante';

  @override
  String get timeToDiscuss => 'Tempo de discussão';

  @override
  String get castYourVote => 'Votem agora';

  @override
  String get whosTheSpy => 'Quem é o Espião?';

  @override
  String get voteToEliminate => 'Votar para eliminar';

  @override
  String get civilianWin => 'Civis Ganham!';

  @override
  String get spyWin => 'Espião Ganha!';

  @override
  String get playAgain => 'Jogar Novamente';

  @override
  String get backToLobby => 'Voltar ao Lobby';

  @override
  String theSpyWas(String name) {
    return 'O Espião era $name';
  }

  @override
  String mrWhiteWas(String name) {
    return 'Mr. White era $name';
  }

  @override
  String wordWas(String word) {
    return 'A palavra era $word';
  }

  @override
  String get needMoreWords => 'Precisas de mais palavras?';

  @override
  String get watchAdOrPass =>
      'Vê um anúncio para +4 rondas ou compra o passe 24h para jogo ilimitado.';

  @override
  String get notNow => 'Agora não';

  @override
  String getPass(String price) {
    return 'Obter Ilimitado ($price)';
  }

  @override
  String get yourTurn => 'Sua Vez';

  @override
  String itsNamesTurn(String name) {
    return 'Vez de $name';
  }

  @override
  String passToName(String name) {
    return 'Passe para $name';
  }

  @override
  String get askQuestion => 'Faça uma pergunta a outro jogador.';

  @override
  String get dontLetOthersSee => 'Não deixe ninguém ver a tela!';

  @override
  String get askYesNoQuestion => 'Faça uma pergunta de sim/não';

  @override
  String get tapDoneWhenFinished => 'Toque em Pronto ao terminar';

  @override
  String get keepScreenHidden => 'Mantenha a tela escondida';

  @override
  String get tapRevealWhenReady =>
      'Toque em \"Revelar Papel\" quando estiver pronto';

  @override
  String iAmNameRevealRole(String name) {
    return 'Eu sou $name, Revelar Papel';
  }

  @override
  String get yourRole => 'Seu Papel';

  @override
  String get youAreTheImpostor => 'VOCÊ É O IMPOSTOR';

  @override
  String get youAreACitizen => 'VOCÊ É UM CIDADÃO';

  @override
  String get blendIn => 'Disfarce';

  @override
  String get impostorInstruction =>
      'Você não sabe a palavra secreta.\nOuça com atenção e finja!';

  @override
  String get theSecretWord => 'A Palavra Secreta';

  @override
  String get dontBeTooObvious => 'Não seja muito óbvio!';

  @override
  String get nextUp => 'Próximo';

  @override
  String get passDeviceInstruction =>
      'Passe o dispositivo para o próximo jogador';

  @override
  String get gotIt => 'Entendi!';

  @override
  String get busted => 'Apanhado!';

  @override
  String get innocent => 'Inocente!';

  @override
  String get youCaughtTheImpostor => 'Apanharam o Impostor!';

  @override
  String get youVotedOutInnocent => 'Expulsaram um cidadão inocente...';

  @override
  String get continueGame => 'Continuar';

  @override
  String get spyEvadedDetection => 'O espião escapou à deteção.';

  @override
  String get hiddenThreatEliminated => 'A ameaça oculta foi eliminada.';

  @override
  String get secretWordWas => 'A palavra secreta era';

  @override
  String get discussionRoom => 'Sala de Discussão';

  @override
  String get votingBooth => 'Cabine de Votação';

  @override
  String get discuss => 'DISCUTIR';

  @override
  String get vote => 'VOTAR';

  @override
  String get shareHints => 'Partilhem pistas. O tempo está a passar.';

  @override
  String get pickWhoToEliminate => 'Escolha quem eliminar';

  @override
  String get remaining => 'restante';

  @override
  String get tradeHints => 'Troquem pistas, notem deslizes.';

  @override
  String get tapToVoteOut => 'Toque para eliminar';

  @override
  String get callAVote => 'Iniciar Votação';

  @override
  String get results => 'Resultados';

  @override
  String get onboardingAppName => 'FESTA DO IMPOSTOR';

  @override
  String get onboardingTagline => 'Jogo de engano para passar.';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingSkipTutorial => 'Pular tutorial';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingStartGame => 'Iniciar Jogo';

  @override
  String get onboardingTitle1 => 'Bem-vindo Agente';

  @override
  String get onboardingDesc1 =>
      'Numa sala cheia de civis, alguém esconde um segredo. Consegues descobrir a verdade?';

  @override
  String get onboardingTitle2 => 'Civil vs Impostor';

  @override
  String get onboardingDesc2 =>
      'Os civis partilham uma palavra secreta. O Impostor tem uma diferente mas deve disfarçar-se.';

  @override
  String get onboardingTitle3 => 'Não Confies em Ninguém';

  @override
  String get onboardingDesc3 =>
      'Discute, vota e elimina o Impostor antes que seja tarde demais.';

  @override
  String get onboardingChip1 => 'Rondas rápidas';

  @override
  String get onboardingChip2 => 'Bluff e dedução';

  @override
  String get onboardingChip3 => 'Passar e jogar';
}
