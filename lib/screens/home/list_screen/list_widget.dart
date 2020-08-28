import 'package:flutter/material.dart';
import 'package:orario/services/lesson.dart';
import 'package:orario/ui.dart';

class ListWidget extends StatelessWidget {
  final Lesson lesson;

  ListWidget({this.lesson});

  @override
  Widget build(BuildContext context) {
    if (lesson == null) {
      return Container(
        height: 0.0,
      );
    } else {
      return Container(
          height: 100.0,
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 5.0),
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(Icons.cake),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      lesson.shortName,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      lesson.location,
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
            ],
          ));
    }
  }
}
