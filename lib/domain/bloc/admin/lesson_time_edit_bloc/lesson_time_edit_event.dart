import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LessonTimeEditEvent extends Equatable {
  const LessonTimeEditEvent();

  @override
  List<Object> get props => [];
}

class LessonTimeOpened extends LessonTimeEditEvent {}

class LessonTimePressSave extends LessonTimeEditEvent {}
