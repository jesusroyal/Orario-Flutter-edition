import 'package:flutter/material.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/domain/repository/settings_repository.dart';

class SettingsDataRepository extends SettingsRepository {
  final SettingsService settingsService;

  SettingsDataRepository({@required this.settingsService});

  @override
  Future<String> getPath() {
    return settingsService.getPath();
  }

  @override
  Future<bool> setPath({String path}) {
    return settingsService.setPath(path: path);
  }
}
