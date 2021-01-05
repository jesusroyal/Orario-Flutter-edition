import 'package:flutter/material.dart';
import 'package:orario/presentation/home/main/current_widget/current_swiper.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: LessonCardContainer(),
                height: constraints.maxHeight * (0.45),
              ),
              Container(
                  height: constraints.maxHeight * (0.30),
                  child: Text('Tommorow')),
            ],
          );
        },
      ),
    );
  }
}
