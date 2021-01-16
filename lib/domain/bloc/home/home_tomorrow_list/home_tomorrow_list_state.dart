import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:orario/domain/model/lesson_pair.dart';

abstract class HomeTomorrowListState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeTomorrowListLoading extends HomeTomorrowListState {}

class HomeTomorrowListLoaded extends HomeTomorrowListState {
  final List<LessonPair> lessons;

  HomeTomorrowListLoaded({@required this.lessons});

  @override
  List<Object> get props => [lessons];
}

class HomeTomorrowListNoLessons extends HomeTomorrowListState {}
