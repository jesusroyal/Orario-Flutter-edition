import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsReset extends SettingsEvent {}

class AdminPageOpen extends SettingsEvent {
  final String token;

  AdminPageOpen({@required this.token});
}
