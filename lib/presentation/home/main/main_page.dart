import 'package:flutter/material.dart';
import 'package:orario/presentation/home/main/current_widget/current_swiper.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: null)],
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: LessonCardContainer(),
                height: constraints.maxHeight * (0.4),
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
