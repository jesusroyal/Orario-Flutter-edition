import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class WelcomePressed extends WelcomeEvent {}

class WelcomeUniversityPressed extends WelcomeEvent {
  final int index;

  WelcomeUniversityPressed({@required this.index});
  @override
  List<Object> get props => [index];
}

class WelcomeGroupPressed extends WelcomeEvent {
  final int index;

  WelcomeGroupPressed({@required this.index});
  @override
  List<Object> get props => [index];
}
