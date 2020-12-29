import 'package:flutter/material.dart';

class OrarioUI {
  static final OrarioUI ref = OrarioUI();
  static final colors = OrarioColor();
  ThemeData lightTheme = ThemeData(
      backgroundColor: colors.background,
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(color: colors.green));
}

class OrarioColor {
  final Color background = Color(0xFFECF3F5);
  final Color green = Color(0xFF01A7C2);
}
