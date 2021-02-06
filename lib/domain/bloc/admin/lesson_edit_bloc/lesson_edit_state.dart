import 'package:equatable/equatable.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class LessonEditState extends Equatable {
  @override
  List<Object> get props => [];
}

class LessonEditLoading extends LessonEditState {}

class LessonEditLoaded extends LessonEditState {
  final Map<int, Map<int, Map<int, LessonPair>>> lessons;

  LessonEditLoaded({this.lessons});

  @override
  List<Object> get props => [lessons];
}
