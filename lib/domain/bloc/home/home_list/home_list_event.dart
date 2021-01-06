import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeListEvent extends Equatable {
  const HomeListEvent();

  @override
  List<Object> get props => [];
}

class HomeListOpened extends HomeListEvent {}

class HomeListDidChooseWeek extends HomeListEvent {
  final bool isSecondWeek;
  HomeListDidChooseWeek({@required this.isSecondWeek});

  @override
  List<Object> get props => [isSecondWeek];
}
