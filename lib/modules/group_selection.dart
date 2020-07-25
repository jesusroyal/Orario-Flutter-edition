import 'package:flutter/material.dart';
import 'package:orario/ui.dart';

class GroupSelection extends StatelessWidget {
  List<String> test = ["БрГТУ", "БНТУ"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        title: Text("Выберите вашу группу"),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(test[index]),
              ),
            );
          }),
    );
  }
}
