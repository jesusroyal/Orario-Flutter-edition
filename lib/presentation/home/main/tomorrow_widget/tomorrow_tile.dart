import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

class TomorrowTile extends StatelessWidget {
  final LessonPair lessonPair;

  const TomorrowTile({Key key, @required this.lessonPair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            margin: EdgeInsets.all(10.0),
            width: 150.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(lessonPair.time.start.format(context)),
                  Text(
                    lessonPair.lesson.name, //TODO: Make short name
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(lessonPair.lesson.location),
                  Divider(
                    color: Colors.amberAccent, //TODO: Add colors
                    thickness: 1.0,
                  )
                ])));
  }
}
