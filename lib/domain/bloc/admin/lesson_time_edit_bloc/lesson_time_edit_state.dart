import 'package:equatable/equatable.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class LessonTimeEditState extends Equatable {
  @override
  List<Object> get props => [];
}

class LessonTimeEditOpened extends LessonTimeEditState {}

class LessonTimeEditLoading extends LessonTimeEditState {}

class LessonTimeEditLoaded extends LessonTimeEditState {
  final List<LessonTime> list;

  LessonTimeEditLoaded(this.list);
}

class LessonTimeEditSaving extends LessonTimeEditState {}
