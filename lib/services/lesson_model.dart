import 'package:flutter/material.dart';
import 'package:orario/services/string_extension.dart';

class Lesson {
  String name;
  String location;
  String don;
  LessonType type;

  String get shortName {
    return this.name.short;
  }

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

extension LessonColor on LessonType {
  Color get color {
    switch (this) {
      case LessonType.lab:
        return Colors.redAccent;
      case LessonType.lecture:
        return Colors.greenAccent;
      case LessonType.seminar:
        return Colors.blueAccent;
    }
    return null;
  }
}
