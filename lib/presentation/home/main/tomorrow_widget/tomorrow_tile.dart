import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/internal/extensions.dart';

class TomorrowTile extends StatelessWidget {
  final LessonPair lessonPair;

  const TomorrowTile({Key key, @required this.lessonPair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            margin: const EdgeInsets.all(10.0),
            width: 150.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(lessonPair.time.start.format(context)),
                  Text(
                    lessonPair.lesson.name.short,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(lessonPair.lesson.location),
                  const Divider(
                    color: Colors.amberAccent, //TODO: Add colors
                    thickness: 1.0,
                  )
                ])));
  }
}
