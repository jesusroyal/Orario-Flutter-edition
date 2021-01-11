class ApiLessonTime {
  final int start;
  final int end;
  final int breakDuration;

  ApiLessonTime.fromApi(dynamic map)
      : start = int.parse(map['start']),
        end = int.parse(map['end']),
        breakDuration = int.parse(
            map['break']); //TODO: Check Firebase for correct break duration key
}
