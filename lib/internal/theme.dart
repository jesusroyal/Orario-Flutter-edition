import 'package:flutter/material.dart';

class OrarioUI {
  static final OrarioUI ref = OrarioUI();
  static final colors = OrarioColor();
  static final text = OrarioTextStyle();
  ThemeData lightTheme = ThemeData(
      backgroundColor: colors.background,
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(color: colors.green));
}

class OrarioColor {
  final Color background = const Color(0xFFECF3F5);
  final Color green = const Color(0xFF01A7C2);
}

class OrarioTextStyle {
  final TextStyle h1Bold =
      const TextStyle(fontSize: 64, fontWeight: FontWeight.w900);
  final TextStyle h2Bold =
      const TextStyle(fontSize: 34, fontWeight: FontWeight.w900);
  final TextStyle h2Light =
      const TextStyle(fontSize: 34, fontWeight: FontWeight.w200);
  final TextStyle h3Bold =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w900);
  final TextStyle h3Light =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w200);
  final TextStyle h4 = const TextStyle(fontSize: 18);
  final TextStyle h4Bold =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w900);
}
