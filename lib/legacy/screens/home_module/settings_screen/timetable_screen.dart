import 'package:flutter/material.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/data/api/model/time.dart';

class TimeTableEditor extends StatefulWidget {
  @override
  _TimeTableEditorState createState() => _TimeTableEditorState();
}

class _TimeTableEditorState extends State<TimeTableEditor> {
  Future<void> _showDialog({BuildContext context, int index}) async {
    TimeOfDay start;
    TimeOfDay end;

    void _savePressed() {
      if (start != null && end != null) {
        OrarioService.timeDict[index] = TimeMoment(start: start, end: end);
        Navigator.pop(context);
      }
    }

    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              Text(
                '${index + 1}-я пара',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    child: Text(
                      'Начало',
                    ),
                    onPressed: () {
                      Future<TimeOfDay> selectedTime = showTimePicker(
                        helpText: 'Начало пары',
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      selectedTime.then((value) => start = value);
                    },
                  ),
                  RaisedButton(
                    child: Text('Конец'),
                    onPressed: () {
                      Future<TimeOfDay> selectedTime = showTimePicker(
                        helpText: 'Конец пары',
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      selectedTime.then((value) => end = value);
                    },
                  )
                ],
              ),
              RaisedButton(
                child: Text('Сохранить'),
                onPressed: () => _savePressed(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание звонков'),
        actions: [SaveButton()],
      ),
      body: ListView.builder(
          itemCount: OrarioService.timeDict.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${index + 1}-я пара'),
                    Text(OrarioService.timeDict[index] == null
                        ? ' '
                        : '${OrarioService.timeDict[index].startString}-${OrarioService.timeDict[index].endString}')
                  ],
                ),
                onTap: () async {
                  await _showDialog(context: context, index: index);
                  setState(() {});
                },
              ),
            );
          }),
    );
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Сохранение расписания звонков'),
          ));
          OrarioService.saveTimeTable()
              .then((value) => Scaffold.of(context).hideCurrentSnackBar());
        });
  }
}
