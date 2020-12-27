import 'setup_event.dart';
import 'setup_state.dart';
import 'package:bloc/bloc.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  SetupBloc() : super(SetupInitial());

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserSetup) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserReset) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<SetupState> _mapAppLoadedToState(AppLoaded event) async* {
    yield SetupLoading();
    try {
      await Future.delayed(Duration(milliseconds: 5500)); // a simulated delay
      final currentUser = 2;

      if (currentUser != null) {
        yield SetupCompleted();
      } else {
        yield SetupNotCompleted();
      }
    } catch (e) {
      yield SetupFailure(message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<SetupState> _mapUserLoggedInToState(UserSetup event) async* {
    yield SetupCompleted();
  }

  Stream<SetupState> _mapUserLoggedOutToState(UserReset event) async* {
    //await _authenticationService.signOut();
    yield SetupNotCompleted();
  }
}
