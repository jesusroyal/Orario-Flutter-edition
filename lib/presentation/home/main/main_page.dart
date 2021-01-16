import 'package:flutter/material.dart';
import 'package:orario/domain/bloc/home/home_tomorrow_list/home_tomorrow_list_bloc.dart';
import 'package:orario/presentation/home/main/current_widget/current_swiper.dart';
import 'package:orario/presentation/home/main/tomorrow_widget/tomorrow_widget.dart';
import 'package:orario/presentation/home/settings.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
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
                child: LessonCardContainer(),
                height: constraints.maxHeight * (0.4),
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
