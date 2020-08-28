import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsService {
  static void resetSettings() {
    SharedPreferences.getInstance().then((sp) {
      sp.clear();
    });
  }
}
