import 'package:meta/meta.dart';

class ApiLesson {
  final String name;
  final String location;
  final String don;
  final int type;

  ApiLesson(
      {@required this.name,
      @required this.location,
      @required this.don,
      @required this.type});

  ApiLesson.fromApi(Map<String, dynamic> map)
      : name = map['name'] as String,
        location = map['location'] as String,
        don = map['don'] as String,
        type = map['type'] as int;

  Map<String, dynamic> toApi() {
    return {'name': name, 'location': location, 'don': don, 'type': type};
  }
}
