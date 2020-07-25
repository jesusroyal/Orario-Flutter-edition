import 'package:flutter/material.dart';
import 'package:orario/ui.dart';
import 'package:orario/modules/group_selection.dart';

class UniversitySelection extends StatelessWidget {
  List<String> test = ["БрГТУ", "БНТУ"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        title: Text("Выберите ваш ВУЗ"),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupSelection()));
                },
                title: Text(test[index]),
              ),
            );
          }),
    );
  }
}
