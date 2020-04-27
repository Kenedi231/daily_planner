import 'package:app_list/core/services/custom_theme_service.dart';
import 'package:app_list/core/services/local_storage_service.dart';

import '../core/logger.dart';
import '../core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(() => NavigatorService());
    _log.d('Initializing Local Storage Service');
    var instance = await LocalStorageService.getInstance();
    locator.registerSingleton<LocalStorageService>(instance);
    _log.d('Initializing Custom Theme Service');
    locator.registerSingleton<CustomThemeService>(CustomThemeService());
  }
}