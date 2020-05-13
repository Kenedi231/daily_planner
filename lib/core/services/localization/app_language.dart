 
import 'dart:async';

import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/local_storage_service.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  final languageKey = 'language_code';
  Locale _appLocale = Locale('en');

  StreamController<Locale> _appLocaleController = StreamController<Locale>();

  Stream<Locale> get appLocale => _appLocaleController.stream;

  Locale get currentLocale => _appLocale;

  AppLanguage() {
    var code = locator<LocalStorageService>().getItem(languageKey);
    if (code == null) {
      _appLocale = Locale('en');
      _appLocaleController.add(_appLocale);
      return;
    }
    _appLocale = Locale(code);
    _appLocaleController.add(_appLocale);
  }

  void changeLanguage(String type) async {
    var storageService = locator<LocalStorageService>();
    if (_appLocale == Locale(type)) {
      return;
    }
    if (AppLocalizations.delegate.isSupported(Locale(type))) {
      _appLocale = Locale(type);
      _appLocaleController.add(_appLocale);
      storageService.setItem(languageKey, type);
    }
    notifyListeners();
  }
}