import 'package:orario/data/api/model/api_model_export.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonMapper {
  static Lesson fromApi(ApiLesson apiLesson) {
    LessonType type;
    switch (apiLesson.type) {
      case 0:
        {
          type = LessonType.lecture;
        }
        break;
      case 1:
        {
          type = LessonType.lab;
        }
        break;
      case 2:
        {
          type = LessonType.seminar;
        }
        break;
      default:
        {
          type = LessonType.lecture;
        }
        break;
    }
    return Lesson(
        name: apiLesson.name,
        location: apiLesson.location,
        don: apiLesson.don,
        type: type);
  }

  static ApiLesson toApi(Lesson lesson) {
    int lessonType = 0;
    switch (lesson.type) {
      case LessonType.lecture:
        {
          lessonType = 0;
        }
        break;
      case LessonType.lab:
        {
          lessonType = 1;
        }
        break;
      case LessonType.seminar:
        {
          lessonType = 2;
        }
        break;
      default:
        {
          lessonType = 0;
        }
        break;
    }
    return ApiLesson(
        name: lesson.name,
        location: lesson.location,
        don: lesson.don,
        type: lessonType);
  }
}
