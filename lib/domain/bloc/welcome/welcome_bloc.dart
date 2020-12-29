import 'package:orario/presentation/welcome/welcome_page.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';
import 'package:bloc/bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super((WelcomeInitial()));

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    print('Got event $event');
    yield WelcomeLoading();
    await Future.delayed(Duration(milliseconds: 5500));
    yield UniversityLoaded(universities: ['Test']);
  }

  Stream<WelcomeState> _mapEventToState(WelcomePressed event) async* {
    yield WelcomeLoading();
  }
}
