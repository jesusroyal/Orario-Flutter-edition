import 'package:equatable/equatable.dart';

abstract class LessonEditState extends Equatable {
  @override
  List<Object> get props => [];
}

class LessonEditLoading extends LessonEditState {}

class LessonEditLoaded extends LessonEditState {
  final Map<int, List> lessons;

  LessonEditLoaded({this.lessons});

  @override
  List<Object> get props => [lessons];
}
