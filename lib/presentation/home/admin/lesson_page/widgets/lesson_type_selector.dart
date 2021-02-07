import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonTypeSelector extends StatefulWidget {
  final ValueChanged<LessonType> onChanged;
  final LessonType currentType;
  const LessonTypeSelector(
      {Key key, @required this.onChanged, this.currentType})
      : super(key: key);

  @override
  _LessonTypeSelectorState createState() {
    switch (currentType) {
      case LessonType.lab:
        return _LessonTypeSelectorState(currentType: 0);
      case LessonType.lecture:
        return _LessonTypeSelectorState(currentType: 0);
      case LessonType.seminar:
        return _LessonTypeSelectorState(currentType: 0);
    }
    return _LessonTypeSelectorState();
  }
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
              widget.onChanged(LessonType.lecture);
            });
          },
        ),
        LessonTypeButton(
          type: LessonType.lab,
          isPressed: currentType == 1,
          onTap: () {
            setState(() {
              currentType = 1;
              widget.onChanged(LessonType.lab);
            });
          },
        ),
        LessonTypeButton(
          type: LessonType.seminar,
          isPressed: currentType == 2,
          onTap: () {
            setState(() {
              currentType = 2;
              widget.onChanged(LessonType.seminar);
            });
          },
        ),
      ],
    );
  }
}

class LessonTypeButton extends StatelessWidget {
  final VoidCallback onTap; //TODO: Change from typealias
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

  const LessonTypeButton(
      {Key key, this.onTap, this.isPressed, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: isPressed ? Colors.green : Colors.amber,

      onPressed: () => onTap(), //TODO: Change colors
      child: Text(_title),
    );
  }
}
