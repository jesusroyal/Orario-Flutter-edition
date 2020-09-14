import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orario/screens/home_module/main_screen/widgets/lesson_card_widget.dart';
import 'package:orario/screens/home_module/main_screen/widgets/tomorrow_sreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сейчас'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: LessonCard(),
                height: constraints.maxHeight * (0.45),
              ),
              Container(
                  height: constraints.maxHeight * (0.30),
                  child: TomorrowWidget()),
            ],
          );
        },
      ),
    );
  }
}
