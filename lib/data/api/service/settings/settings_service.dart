import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<String> getPath() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String path = sp.getString('path');
    return path;
  }

  Future<int> getSubgroup() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final int index = sp.getInt('subg');
    return index;
  }

  Future<bool> setPath({@required String path}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString('path', path);
  }

  Future<bool> setSubgroup(int index) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setInt('subg', index);
  }

  Future<void> resetPath() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('path', null);
    return;
  }
}
