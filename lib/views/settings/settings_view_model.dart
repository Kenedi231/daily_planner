import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends BaseViewModel {
  static const LIGHT_THEME = 'light_theme';
  static const NICKNAME = 'nickname';

  SettingsViewModel();

  bool darkMode = false;
  String currentLocal = 'en';
  bool wrongName = false;
  String name = '';
  TextEditingController controller = TextEditingController();
  FocusNode focusNodeName = FocusNode();
  List<String> locales = List<String>();

  void init() {
    locales.addAll(AppLocalizations.locales);
    name = storageService.getItem(NICKNAME) ?? '';
    controller.text = name;
    currentLocal = localeController.currentLocale.languageCode;

    bool theme = storageService.getItem(LIGHT_THEME);
    darkMode = !(theme ?? true);
  }

  void saveName() {
    wrongName = controller.text.length == 0;
    if (controller.text.length != 0) {
      focusNodeName.unfocus();
      storageService.setItem(NICKNAME, controller.text);
    }
    notifyListeners();
  }

  void changeLocale(String locale) {
    localeController.changeLanguage(locale);
    currentLocal = locale;
    notifyListeners();
  }
  
  void changeTheme() {
    themeService.switchTheme();
    bool theme = themeService.islightTheme;
    darkMode = !theme;
    storageService.setItem(LIGHT_THEME, theme);
    notifyListeners();
  }
}