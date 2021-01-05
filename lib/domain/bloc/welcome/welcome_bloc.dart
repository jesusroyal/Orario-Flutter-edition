import 'package:orario/data/api/service/login/login_service.dart';
import 'package:orario/data/repository/login/login_data_repository.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';
import 'package:bloc/bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super((WelcomeInitial()));

  LoginDataRepository loginRepository = LoginDataRepository(LoginService());

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    //TODO: Refactor
    if (event is WelcomePressed) {
      yield WelcomeLoading();
      var map = await loginRepository.getUniversities();
      List<String> list = [];
      map.forEach((key, value) {
        list.add(value);
      });
      yield UniversityLoaded(universities: list);
    }
    if (event is UniversityPressed) {
      yield GroupsLoading();

      var mapUni = await loginRepository.getUniversities();
      List<String> listUni = [];
      mapUni.forEach((key, value) {
        listUni.add(value);
      });

      var index = mapUni.keys.firstWhere(
          (k) => mapUni[k] == listUni[event.index],
          orElse: () => null);

      var map = await loginRepository.getGroups(university: index);
      List<String> list = [];
      map.forEach((key, value) {
        list.add(value);
      });

      yield GroupsLoaded(groups: list);
    }
  }
}
