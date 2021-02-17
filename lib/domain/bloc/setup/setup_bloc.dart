import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:bloc/bloc.dart';

import 'setup_event.dart';
import 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  SetupBloc() : super(SetupInitial());

  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is AppLoaded) {
      yield SetupLoading();
      final String path = await settings.getPath();
      if (path == null) {
        yield SetupNotCompleted();
      } else {
        yield SetupCompleted();
      }
    }
  }
}
