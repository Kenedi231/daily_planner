import 'package:app_list/core/base/base_view_model.dart';

class SettingsViewModel extends BaseViewModel {
  static const LIGHT_THEME = 'light_theme';

  SettingsViewModel();

  bool darkMode = false;

  void init() {
    bool theme = storageService.getItem(LIGHT_THEME);
    darkMode = !(theme ?? true);
  }
  
  void changeTheme() {
    themeService.switchTheme();
    bool theme = themeService.islightTheme;
    darkMode = !theme;
    storageService.setItem(LIGHT_THEME, theme);
    notifyListeners();
  }
  // Add ViewModel specific code here
}