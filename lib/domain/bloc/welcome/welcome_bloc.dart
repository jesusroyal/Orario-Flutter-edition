import 'welcome_event.dart';
import 'welcome_state.dart';
import 'package:bloc/bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super((WelcomeInitial()));

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    if (event is WelcomePressed) {
      yield WelcomeLoading();
      await Future.delayed(Duration(milliseconds: 5500));
      yield UniversityLoaded(universities: ['Test']);
    }
    if (event is UniversityPressed) {
      yield GroupsLoading();
      await Future.delayed(Duration(milliseconds: 5500));
      yield GroupsLoaded(groups: ['test']);
    }
  }
}
