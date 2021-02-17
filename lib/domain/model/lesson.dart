import 'package:meta/meta.dart';
import './lesson_type.dart';

class Lesson {
  final String name;
  final String location;
  final String don;
  final LessonType type;

  Lesson({
    @required this.name,
    @required this.location,
    @required this.don,
    @required this.type
  });
}