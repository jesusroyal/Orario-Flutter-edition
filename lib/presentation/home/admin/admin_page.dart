import 'package:flutter/material.dart';
import 'package:orario/presentation/home/admin/lesson_page/lesson_page.dart';
import 'package:orario/presentation/home/admin/lesson_time_page/lesson_time_page.dart';

class AdminPage extends StatelessWidget {
  Widget lessonTimeEditTile(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Расписания звонков'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonTimePage(),
                ),
              );
            }));
  }

  Widget lessonEditTile(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Расписания занятий'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonPage(),
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [lessonTimeEditTile(context), lessonEditTile(context)];
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: tiles.length,
            itemBuilder: (context, index) {
              return tiles[index];
            }));
  }
}
