import 'package:equatable/equatable.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class LessonEditEvent extends Equatable {
  const LessonEditEvent();

  @override
  List<Object> get props => [];
}

class LessonEditOpened extends LessonEditEvent {}

class LessonEditChangedWeek extends LessonEditEvent {
  final int week;

  LessonEditChangedWeek(this.week);
}

class LessonEditSave extends LessonEditEvent {
  final Map<int, Map<int, Map<int, LessonPair>>> lessons;

  LessonEditSave({this.lessons});
}
