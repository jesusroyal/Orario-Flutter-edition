import 'package:firebase_database/firebase_database.dart';

class Lesson {
  String name;
  String location;
  String don;
  LessonType type;

  Lesson({this.name, this.location, this.don, int type}) {
    switch (type) {
      case 0:
        {
          this.type = LessonType.lecture;
        }
        break;
      case 1:
        {
          this.type = LessonType.lab;
        }
        break;
      case 2:
        {
          this.type = LessonType.seminar;
        }
        break;
      default:
        {
          this.type = LessonType.lecture;
        }
        break;
    }
  }

  Lesson.fromDynamicMap(dynamic map) {
    name = map["name"].toString();
    location = map["location"].toString();
    don = map["don"].toString();
    type = LessonType.lab;
    switch (map['type']) {
      case 0:
        {
          this.type = LessonType.lecture;
        }
        break;
      case 1:
        {
          this.type = LessonType.lab;
        }
        break;
      case 2:
        {
          this.type = LessonType.seminar;
        }
        break;
      default:
        {
          this.type = LessonType.lecture;
        }
        break;
    }
  }
}

enum LessonType { lecture, lab, seminar }
