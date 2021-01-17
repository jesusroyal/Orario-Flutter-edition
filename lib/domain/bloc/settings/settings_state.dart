import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsOpened extends SettingsState {}

class ResetSettingsState extends SettingsState {}

class OpenAdminPanel extends SettingsState {}

class TokenError extends SettingsState {}
