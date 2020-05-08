import 'package:flutter/material.dart';

final ThemeData lightTheme = _lightTheme();

ThemeData _lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.redAccent,
    backgroundColor: Colors.white,
    accentColor: Colors.grey[400],
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    buttonColor: Colors.redAccent,
    textTheme: _buildLightTextTheme(base.textTheme),
    primaryTextTheme: _buildLightTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildLightTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    headline5: base.headline5.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headline6: base.headline6.copyWith(
      color: Colors.white,
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: Colors.redAccent,
    ),
    bodyText2: base.bodyText2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: Colors.white,
    ),
    headline4: base.headline4.copyWith(
      color: Colors.grey[300],
    ),
  );
}