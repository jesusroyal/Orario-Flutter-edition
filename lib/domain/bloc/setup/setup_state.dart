import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SetupState extends Equatable {
  @override
  List<Object> get props => [];
}

class SetupInitial extends SetupState {}

class SetupNotCompleted extends SetupState {}

class SetupCompleted extends SetupState {}

class SetupLoading extends SetupState {}

class SetupFailure extends SetupState {
  final String message;

  SetupFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
