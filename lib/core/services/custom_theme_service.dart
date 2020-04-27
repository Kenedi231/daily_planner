import 'dart:async';

import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/local_storage_service.dart';

class CustomThemeService {
  bool _lightTheme = true;

  StreamController<bool> _themeController = StreamController<bool>();

  Stream<bool> get theme => _themeController.stream;

  bool get islightTheme => _lightTheme;

  void switchTheme() {
    if (_lightTheme) {
      _themeController.add(false);
    } else {
      _themeController.add(true);
    }
    _lightTheme = !_lightTheme;
  }

  CustomThemeService() {
    bool theme = locator<LocalStorageService>().getItem('light_theme');
    if (theme == null || theme) {
      _themeController.add(true);
      _lightTheme = true;
    } else {
      _themeController.add(false);
      _lightTheme = false;
    }
  }
}