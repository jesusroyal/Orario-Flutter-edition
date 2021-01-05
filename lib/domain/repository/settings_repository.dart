import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<String> getPath();
  Future<bool> setPath({@required String path});
}
