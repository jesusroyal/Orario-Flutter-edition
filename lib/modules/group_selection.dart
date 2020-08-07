import 'package:flutter/material.dart';
import 'package:orario/modules/list_screen.dart';
import 'package:orario/services/setup_service.dart';
import 'package:orario/ui.dart';

class GroupSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        title: Text("Выберите вашу группу"),
      ),
      body: ListView.builder(
          itemCount: SetupService.groupData.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  SetupService.setGroupTo(
                      group: SetupService.groupData[index],
                      ready: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen()));
                      });
                },
                title: Text(SetupService.groupData[index]),
              ),
            );
          }),
    );
  }
}
