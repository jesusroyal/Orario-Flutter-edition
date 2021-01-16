import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_event.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_state.dart';

class CurrentTileBloc extends Bloc<CurrentTileEvent, CurrentTileState> {
  CurrentTileBloc() : super(CurrentTileLoading());

  @override
  Stream<CurrentTileState> mapEventToState(CurrentTileEvent event) async* {
    yield CurrentTileLoading();
  }
}
