class ApiLesson {
  final String name;
  final String location;
  final String don;
  final int type;

  ApiLesson.fromApi(Map<String, dynamic> map)
      : name = map['name'],
        location = map['location'],
        don = map['don'],
        type = map['type'];

  Map<String, dynamic> toApi() {
    return {'name': name, 'location': location, 'don': don, 'type': type};
  }

  ApiLesson({this.name, this.location, this.don, this.type});
}
