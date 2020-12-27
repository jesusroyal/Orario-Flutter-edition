import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SetupEvent extends Equatable {
  const SetupEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends SetupEvent {}

class UserSetup extends SetupEvent {}

class UserReset extends SetupEvent {}
