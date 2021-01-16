import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CurrentTileEvent extends Equatable {
  const CurrentTileEvent();

  @override
  List<Object> get props => [];
}

class CurrentTileOpened extends CurrentTileEvent {}
