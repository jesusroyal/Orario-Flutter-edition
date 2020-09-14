import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Пара закончится через 30 минут'),
            Text('МСиСвРЭ'),
            Text('228-8'),
            Text('Иванов И. И.'),
          ],
        ),
      ),
    );
  }
}
