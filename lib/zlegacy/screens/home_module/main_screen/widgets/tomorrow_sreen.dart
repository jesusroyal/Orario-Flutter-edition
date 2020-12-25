import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/main_screen/widgets/tomorrow_screen_widgets.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/services/time_service.dart';

// ignore: must_be_immutable
class TomorrowWidget extends StatelessWidget {
  int day = (TimeService.day + 1 == 6 || TimeService.day == 6)
      ? 0
      : TimeService.day + 1;
  int week = TimeService.week;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                TimeService.day + 1 == 6 ? 'Послезавтра' : 'Завтра',
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
