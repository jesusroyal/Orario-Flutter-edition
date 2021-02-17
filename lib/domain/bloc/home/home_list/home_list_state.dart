import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class HomeListState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeListLoading extends HomeListState {}

class HomeListLoaded extends HomeListState {
  final Map<int, List<LessonPair>> lessons;
  final int currentLesson;
  final bool isSecondWeek;

  HomeListLoaded(
      {@required this.isSecondWeek,
      @required this.lessons,
      @required this.currentLesson});
  @override
  List<Object> get props => [lessons, currentLesson];
}
