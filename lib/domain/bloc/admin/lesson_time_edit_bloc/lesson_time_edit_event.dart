import 'package:equatable/equatable.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class LessonTimeEditEvent extends Equatable {
  const LessonTimeEditEvent();

  @override
  List<Object> get props => [];
}

class LessonTimeOpened extends LessonTimeEditEvent {}

class LessonTimePressSave extends LessonTimeEditEvent {
  final List<LessonTime> list;

  const LessonTimePressSave(this.list);
}
