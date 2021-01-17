import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<String> getPath() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String path = sp.getString('path');
    return path;
  }

  Future<bool> setPath({@required String path}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString('path', path);
  }

  Future<void> resetPath() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('path', null);
    return;
  }
}
