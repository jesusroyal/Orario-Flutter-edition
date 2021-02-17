import 'package:equatable/equatable.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:meta/meta.dart';

abstract class LessonEditEvent extends Equatable {
  const LessonEditEvent();

  @override
  List<Object> get props => [];
}

class LessonEditOpened extends LessonEditEvent {}

class LessonEditChangedWeek extends LessonEditEvent {
  final int week;

  const LessonEditChangedWeek(this.week);
}

class LessonEditCopyWeek extends LessonEditEvent {
  final Map<int, Map<int, Map<int, LessonPair>>> lessons;

  const LessonEditCopyWeek({@required this.lessons});
}

class LessonEditSave extends LessonEditEvent {
  final Map<int, Map<int, Map<int, LessonPair>>> lessons;
  final int week;
  const LessonEditSave({@required this.week, @required this.lessons});
}
