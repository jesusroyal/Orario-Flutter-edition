import 'package:equatable/equatable.dart';

abstract class HomeTomorrowListEvent extends Equatable {
  const HomeTomorrowListEvent();

  @override
  List<Object> get props => [];
}

class HomeTomorrowListOpened extends HomeTomorrowListEvent {}
