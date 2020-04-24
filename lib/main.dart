import 'package:app_list/core/services/local_storage_service.dart';
import 'package:app_list/theme/light.dart';
import 'package:app_list/theme/night.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home/home_view.dart';

void main() async {
  await LocalStorageService.init();
  await LocatorInjector.setupLocator();
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        theme: nightTheme,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        home: FutureBuilder(
          future: LocalStorageService.storage.ready,
          builder: (context, snapshot) => HomeView()
        ),
      ),
    );
  }
}