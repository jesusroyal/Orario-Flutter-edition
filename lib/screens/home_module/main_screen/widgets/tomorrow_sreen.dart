import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/main_screen/widgets/tomorrow_screen_widgets.dart';
import 'package:orario/screens/ui_constants.dart';

class TomorrowWidget extends StatelessWidget {
  int day = DateTime.now().weekday;
  int week;

  TomorrowWidget() {
    String date = DateTime.now().toString();
    String firstDay = date.substring(0, 7) + '01' + date.substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;
    int currentWeek;
    if (weekDay == 7) {
      currentWeek = (DateTime.now().day / 7).ceil();
    } else {
      currentWeek = ((DateTime.now().day + weekDay) / 7).ceil();
    }
    week = currentWeek.isEven ? 1 : 0;
    if (day == 7) {
      day = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Завтра',
                style: OrarioText.h4,
              )),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return TomorrowScreenLessonWidget(
                    path: "$week/$day/$index",
                  );
                }),
          ),
        ],
      ),
    );
  }
}
