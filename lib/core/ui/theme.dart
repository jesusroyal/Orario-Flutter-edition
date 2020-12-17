import 'package:flutter/material.dart';
import 'package:orario/core/ui/colors.dart';

class OrarioTheme {
  static final _colors = OrarioColors();

  ThemeData light = ThemeData(
      appBarTheme: AppBarTheme(color: _colors.darkAccent),
      backgroundColor: _colors.background,
      scaffoldBackgroundColor: _colors.background,
      accentColor: _colors.darkAccent);

  final ThemeData dark = ThemeData(brightness: Brightness.dark);
}
