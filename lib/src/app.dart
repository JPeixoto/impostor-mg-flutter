import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'game_controller.dart';
import 'features/settings/settings_controller.dart';
import 'main_screen.dart';
import 'monetization/monetization_controller.dart';

import 'core/theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MonetizationController()..init()),
        ChangeNotifierProvider(
          create: (_) => SettingsController()..loadSettings(),
        ),
        ChangeNotifierProxyProvider<MonetizationController, GameController>(
          create: (_) => GameController(),
          update: (_, monetization, controller) {
            final gameController = controller ?? GameController();
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
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('pt'), // Portuguese
            ],
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
