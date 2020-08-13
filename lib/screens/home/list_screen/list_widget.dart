import 'package:flutter/material.dart';
import 'package:orario/services/lesson.dart';

class ListWidget extends StatelessWidget {
  Lesson lesson;

  ListWidget({this.lesson});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Icon(Icons.camera),
              SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    lesson.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        lesson.location,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        lesson.don,
                        textAlign: TextAlign.right,
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
