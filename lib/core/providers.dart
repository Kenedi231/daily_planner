import 'package:app_list/core/services/custom_theme_service.dart';
import 'package:app_list/core/services/local_storage_service.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';
import 'package:provider/provider.dart';

class ProviderInjector {
  static List<SingleChildCloneableWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static List<SingleChildCloneableWidget> _independentServices = [
    Provider.value(value: locator<NavigatorService>()),
    Provider.value(value: locator<LocalStorageService>()),
  ];

  static List<SingleChildCloneableWidget> _dependentServices = [];
  
  static List<SingleChildCloneableWidget> _consumableServices = [
    StreamProvider<bool>(
      create: (context) => locator<CustomThemeService>().theme,
    ),
  ];
}