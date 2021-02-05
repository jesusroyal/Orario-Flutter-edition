import 'package:flutter/material.dart';
import 'package:orario/presentation/home/main/current_widget/current_swiper.dart';
import 'package:orario/presentation/home/main/tomorrow_widget/tomorrow_widget.dart';
import 'package:orario/presentation/home/settings/settings.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              })
        ],
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: constraints.maxHeight * (0.4),
                child: const LessonCardContainer(),
              ),
              Container(
                height: constraints.maxHeight * (0.30),
                child: HomeTomorrowListWidget(),
              )
            ],
          );
        },
      ),
    );
  }
}
