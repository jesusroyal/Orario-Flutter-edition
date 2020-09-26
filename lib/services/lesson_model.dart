import 'package:flutter/material.dart';

class Lesson {
  String name;
  String location;
  String don;
  LessonType type;

  String get shortName {
    if (this.name.length <= 10) {
      return this.name;
    }

    if (this.name.length > 25) {
      String output = '';
      List<String> words = this.name.split(" ");

      words.forEach((word) {
        output += word[0];
      });
      return output;
    }

    String output = '';
    List<String> words = this.name.split(" ");

    words.forEach((word) {
      if (word.length > 4) {
        output += (word.substring(0, 4) + '. ');
      } else {
        output += word;
      }
    });
    return output;
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
