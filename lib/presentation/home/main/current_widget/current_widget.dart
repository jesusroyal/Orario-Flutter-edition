import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/internal/theme.dart';
import 'package:orario/internal/extensions.dart';

class LessonCard extends StatelessWidget {
  final LessonPair lesson;

  const LessonCard({Key key, @required this.lesson}) : super(key: key);

  String estimatedLine(LessonTime time) {
    final now = TimeOfDay.now().inMinutes;
    if (time.start.inMinutes < now && time.end.inMinutes > now) {
      return 'Осталось ${time.end.inMinutes - now} минут';
    } else if (time.start.inMinutes > now) {
      return 'Через ${time.start.inMinutes - now} минут';
    } else {
      return 'Закончилась ${now - time.end.inMinutes} минут назад';
    }
  }

  double get progress {
    return TimeOfDay.now().inMinutes /
        (lesson.time.end.inMinutes - lesson.time.start.inMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              estimatedLine(lesson.time),
              style: OrarioUI.text.h3Light,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 120.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          lesson.lesson.location,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          lesson.lesson.don,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  lesson.lesson.name.short,
                  style: OrarioUI.text.h2Bold,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(
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
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: LinearProgressIndicator(
                    backgroundColor: lesson.lesson.type.color,
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
