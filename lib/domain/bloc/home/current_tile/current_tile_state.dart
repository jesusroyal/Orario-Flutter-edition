import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class CurrentTileState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentTileLoading extends CurrentTileState {}

class CurrentTileLoaded extends CurrentTileState {
  final List<LessonPair> lessons;
  final int currentLesson;

  CurrentTileLoaded({@required this.lessons, this.currentLesson});
}

class CurrentTileNoLessons extends CurrentTileState {}
