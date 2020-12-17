import 'dart:async';

import 'package:orario/services/orario_service.dart';

enum AppState { loading, login, home }

class AppStream {
  StreamController _streamController = StreamController<AppState>();

  Stream<AppState> get stream => _streamController.stream;

  void init() async {
    _streamController.add(AppState.loading);
    bool val = await OrarioService.setupApp();
    if (val) {
      _streamController.add(AppState.login);
    } else {
      _streamController.add(AppState.home);
    }
  }
}
