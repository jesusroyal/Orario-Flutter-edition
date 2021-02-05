import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonTypeSelector extends StatefulWidget {
  final ValueChanged<int> onTap;
  final int currentType;
  const LessonTypeSelector({Key key, this.onTap, this.currentType})
      : super(key: key);

  @override
  _LessonTypeSelectorState createState() =>
      _LessonTypeSelectorState(currentType: currentType);
}

class _LessonTypeSelectorState extends State<LessonTypeSelector> {
  int currentType = 0;

  _LessonTypeSelectorState({this.currentType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LessonTypeButton(
          type: LessonType.lecture,
          isPressed: currentType == 0,
          onTap: () {
            setState(() {
              currentType = 0;
              widget.onTap(currentType);
            });
          },
        ),
        LessonTypeButton(
          type: LessonType.lab,
          isPressed: currentType == 1,
          onTap: () {
            setState(() {
              currentType = 1;
              widget.onTap(currentType);
            });
          },
        ),
        LessonTypeButton(
          type: LessonType.seminar,
          isPressed: currentType == 2,
          onTap: () {
            setState(() {
              currentType = 2;
              widget.onTap(currentType);
            });
          },
        ),
      ],
    );
  }
}

class LessonTypeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPressed;
  final LessonType type;

  String get _title {
    switch (type) {
      case LessonType.lab:
        return 'Лаба';
      case LessonType.lecture:
        return 'Лекция';
      case LessonType.seminar:
        return 'Семинар';
    }
    return '';
  }

  IconData get _icon {
    switch (type) {
      case LessonType.lab:
        return Icons.computer;
      case LessonType.lecture:
        return Icons.book;
      case LessonType.seminar:
        return Icons.brush;
    }
    return null;
  }

  LessonTypeButton({Key key, this.onTap, this.isPressed, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: isPressed ? Colors.green : Colors.amber, //TODO: Change colors
      child: Row(
        children: [
          Icon(_icon),
          SizedBox(
            width: 10.0,
          ),
          Text(_title),
        ],
      ),
      onPressed: () => onTap(),
    );
  }
}
