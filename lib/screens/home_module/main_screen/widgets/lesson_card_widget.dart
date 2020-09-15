import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';

class LessonCard extends StatelessWidget {
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
              'Пара закончится через 30 минут',
              style: OrarioText.h4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueAccent,
                  ),
                  child: Container(
                    width: 120.0,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          '228-8',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Иванов И. И.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'МСиСвРЭ',
                  style: OrarioText.h1,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('11:30'), Text('11:40')],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueAccent,
                  ),
                  height: 10.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
