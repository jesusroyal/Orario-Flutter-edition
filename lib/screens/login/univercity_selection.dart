import 'package:flutter/material.dart';
import 'package:orario/screens/loading_dialog.dart';
import 'package:orario/services/setup_service.dart';
import 'package:orario/ui.dart';
import 'package:orario/screens/login/group_selection.dart';

class UniversitySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        title: Text("Выберите ваш ВУЗ"),
      ),
      body: ListView.builder(
          itemCount: SetupService.univercityData.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  showDialog(
                      context: context, builder: (context) => LoadingDialog());
                  SetupService.getGroupDataFor(
                      univercity: SetupService.univercityData[index],
                      ready: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupSelection()));
                      });
                },
                title: Text(SetupService.univercityData[index]),
              ),
            );
          }),
    );
  }
}
