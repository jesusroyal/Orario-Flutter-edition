import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:orario/presentation/home/main/current_widget/current_widget.dart';

class LessonCardContainer extends StatefulWidget {
  LessonCardContainer({Key key}) : super(key: key);

  @override
  _LessonCardContainerState createState() => _LessonCardContainerState();
}

class _LessonCardContainerState extends State<LessonCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      index: 0,
      scrollDirection: Axis.vertical,
      loop: false,
      itemCount: 2,
      control: null,
      itemBuilder: (BuildContext context, int index) {
        return LessonCard();
      },
    );
  }
}
