import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WelcomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class UniversityLoaded extends WelcomeState {
  final List<String> universities;

  UniversityLoaded({@required this.universities});

  @override
  List<Object> get props => [universities];
}

class GroupsLoading extends WelcomeState {}

class GroupsLoaded extends WelcomeState {
  final List<String> groups;

  GroupsLoaded({@required this.groups});

  @override
  List<Object> get props => [groups];
}

class WelcomeComplete extends WelcomeState {}
