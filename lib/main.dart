import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_list/theme/light.dart';
import 'package:app_list/theme/night.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: Consumer<bool>(
        builder: (context, theme, child) => Consumer<Locale>(
          builder: (context, appLocale, child) => MaterialApp(
            locale: appLocale,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ru', 'RU'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: theme ?? true ? lightTheme : nightTheme,
            navigatorKey: locator<NavigatorService>().navigatorKey,
            home: HomeView(),
          ),
        ),
      ),
    );
  }
}