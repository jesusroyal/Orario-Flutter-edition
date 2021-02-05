import 'package:flutter/material.dart';
import 'package:orario/domain/model/lesson_pair.dart';
import 'package:orario/internal/theme.dart';

class ListWidget extends StatelessWidget {
  final LessonPair lessonPair;

  const ListWidget({Key key, @required this.lessonPair}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(2.0),
      child: Container(
          height: 70.0,
          color: Colors.white,
          margin: const EdgeInsets.all(7.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(lessonPair.time.start.format(context)),
                  Text(
                    lessonPair.time.end.format(context),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const VerticalDivider(
                color: Colors.deepOrange, //TODO: Add colors
                thickness: 1.0,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lessonPair.lesson.name,
                          style: OrarioUI.text.h4,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          lessonPair.lesson.don,
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Text(
                      lessonPair.lesson.location,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
