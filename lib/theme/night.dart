import 'package:flutter/material.dart';

final ThemeData nightTheme = _nightTheme();

ThemeData _nightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.grey[900],
    backgroundColor: Colors.grey[700],
    accentColor: Colors.grey[400],
    iconTheme: IconThemeData(
      color: Colors.blueAccent,
    ),
    textTheme: _buildLightTextTheme(base.textTheme).apply(
      bodyColor: Colors.white,
    ),
    buttonColor: Colors.blueAccent,
    primaryTextTheme: _buildLightTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildLightTextTheme(base.accentTextTheme),
    
  );
}

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
      color: Colors.white,
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: Colors.white,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: Colors.white,
    ),
    display4: base.display4.copyWith(
      color: Colors.white,
    )
  );
}