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

  const UniversityPressed({@required this.index});
  @override
  List<Object> get props => [index];
}

class GroupPressed extends WelcomeEvent {
  final int index;

  const GroupPressed({@required this.index});
  @override
  List<Object> get props => [index];
}

class SubGroupPressed extends WelcomeEvent {
  final int subGroup;

  const SubGroupPressed(this.subGroup);

  @override
  List<Object> get props => [subGroup];
}
