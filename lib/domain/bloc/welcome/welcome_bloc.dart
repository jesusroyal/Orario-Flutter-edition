import 'package:flutter/material.dart';
import 'package:orario/data/api/service/login/login_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/login/login_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';
import 'package:bloc/bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super((WelcomeInitial()));

  LoginDataRepository loginRepository = LoginDataRepository(LoginService());
  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  Map<String, String> universityMap = {};
  Map<String, String> groupMap = {};

  List<String> universityList = [];
  List<String> groupList = [];

  String uni = '';
  String group = '';

  List<String> mapToList(Map<String, String> map) {
    List<String> list = [];
    map.forEach((key, value) {
      list.add(value);
    });
    return list;
  }

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    //TODO: Refactor
    if (event is WelcomePressed) {
      yield WelcomeLoading();
      universityMap = await loginRepository.getUniversities();
      universityList = mapToList(universityMap);
      yield UniversityLoaded(universities: universityList);
    }
    if (event is UniversityPressed) {
      yield GroupsLoading();

      uni = universityMap.keys.firstWhere(
          (k) => universityMap[k] == universityList[event.index],
          orElse: () => null);

      groupMap = await loginRepository.getGroups(university: uni);
      groupList = mapToList(groupMap);

      yield GroupsLoaded(groups: groupList);
    }

    if (event is GroupPressed) {
      group = groupMap.keys.firstWhere(
          (k) => groupMap[k] == groupList[event.index],
          orElse: () => null);
      await settings.setPath(path: '$uni/$group');
      print('$uni/$group');
      yield WelcomeComplete();
    }
  }
}
