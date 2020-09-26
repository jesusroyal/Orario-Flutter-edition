import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:orario/services/time_model.dart';

class LessonCard extends StatelessWidget {
  final TimeOfDay now = TimeOfDay.now();
  final Lesson lesson;
  final TimeMoment time;

  LessonCard({@required this.lesson, @required this.time});

  String get estimated {
    int nowMinutes = now.hour * 60 + now.minute;

    if (nowMinutes < time.startInt) {
      return 'Пара начнется через ${time.startInt - nowMinutes} мин.';
    }

    if (nowMinutes > time.endInt) {
      return 'Пара закочилась ${nowMinutes - time.endInt} мин. назад';
    }

    if (nowMinutes >= time.startInt && nowMinutes < time.endInt) {
      return 'Пара закочится чере ${time.endInt - nowMinutes} мин.';
    }

    return '';
  }

  double get progress {
    int nowMinutes = (now.hour * 60 + now.minute) - time.startInt;
    int duration = time.endInt - time.startInt;

    return nowMinutes / duration;
  }

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
              estimated,
              style: OrarioText.h4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: lesson.type.color,
                  ),
                  child: Container(
                    width: 120.0,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          lesson.location,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          lesson.don,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  lesson.shortName,
                  style: OrarioText.h1,
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
                  children: [Text(time.startString), Text(time.endString)],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: LinearProgressIndicator(
                    minHeight: 10.0,
                    value: progress,
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
