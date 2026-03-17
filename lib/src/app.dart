import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'game_controller.dart';
import 'features/settings/settings_controller.dart';
import 'main_screen.dart';
import 'monetization/monetization_controller.dart';
import 'models/game_state.dart';

import 'core/theme.dart';

import 'package:my_app/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.initialGameState,
    required this.monetizationController,
  });

  final GameState initialGameState;
  final MonetizationController monetizationController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MonetizationController>.value(
          value: monetizationController,
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsController()..loadSettings(),
        ),
        ChangeNotifierProxyProvider<MonetizationController, GameController>(
          create: (_) => GameController(initialState: initialGameState),
          update: (_, monetization, controller) {
            final gameController =
                controller ?? GameController(initialState: initialGameState);
            gameController.updateMonetization(monetization);
            return gameController;
          },
        ),
      ],
      child: Consumer<SettingsController>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'Impostor',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
