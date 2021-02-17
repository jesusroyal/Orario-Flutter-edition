import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<String> getPath();
  Future<int> getSubgroup();
  Future<bool> setPath({@required String path});
  Future<bool> setSubgroup(int index);
  Future<void> resetPath();
}
