class ApiLessonTime {
  final int start;
  final int end;
  final int breakDuration;

  ApiLessonTime.fromApi(Map<String, int> map)
    : start = map['start'],
    end = map['end'],
    breakDuration = map['break']; //TODO: Check Firebase for correct break duration key
}