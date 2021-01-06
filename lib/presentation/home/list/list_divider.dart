import 'package:flutter/material.dart';

class ListSection extends StatelessWidget {
  final int _section;

  final _sectionArray = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота"
  ];

  ListSection(this._section);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 0, 5.0),
        child: Text(
          _sectionArray[_section],
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
