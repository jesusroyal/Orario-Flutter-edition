import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/admin/admin_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/admin/admin_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/bloc/settings/settings_event.dart';
import 'package:orario/domain/bloc/settings/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsOpened());

  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  AdminDataRepository admin = AdminDataRepository(AdminService());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsReset) {
      await settings.resetPath();
      yield ResetSettingsState();
    }
    if (event is AdminPageOpen) {
      yield SettingsLoading();
      final String path = await settings.getPath();
      final bool isValid =
          await admin.ferifyToken(token: event.token, path: path);
      if (isValid) {
        yield OpenAdminPanel();
      } else {
        yield TokenError();
      }
    }
  }
}
