import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class WelcomePressed extends WelcomeEvent {}

class UniversityPressed extends WelcomeEvent {
  final int index;

  UniversityPressed({@required this.index});
  @override
  List<Object> get props => [index];
}

class GroupPressed extends WelcomeEvent {
  final int index;

  GroupPressed({@required this.index});
  @override
  List<Object> get props => [index];
}
