abstract class LessonRepository {
  Future<Map<int, Map>> getLessons(String path, int subGroup);
}
