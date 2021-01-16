import 'package:flutter/material.dart';
import 'package:orario/domain/model/lesson_pair.dart';

class LessonCard extends StatelessWidget {
  final LessonPair lesson;

  const LessonCard({Key key, @required this.lesson}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Осталось',
              style: null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: null,
                  ),
                  child: Container(
                    width: 120.0,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          lesson.lesson.location,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          lesson.lesson.don,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  lesson.lesson.name,
                  style: null,
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 3.0,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lesson.time.start.format(context)),
                    Text(lesson.time.end.format(context))
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: LinearProgressIndicator(
                    minHeight: 10.0,
                    value: 5,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
