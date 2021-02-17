import 'package:equatable/equatable.dart';

abstract class CurrentTileEvent extends Equatable {
  const CurrentTileEvent();

  @override
  List<Object> get props => [];
}

class CurrentTileOpened extends CurrentTileEvent {}
