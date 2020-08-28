import 'package:flutter/material.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/screens/ui_constants.dart';

class GroupSelection extends StatelessWidget {
  final Map<String, String> groupMap;
  final List<String> _groupList = [];

  GroupSelection({this.groupMap}) {
    groupMap.forEach((key, value) {
      _groupList.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        title: Text("Выберите вашу группу"),
      ),
      body: ListView.builder(
          itemCount: _groupList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  OrarioService.fetchDataFor(
                      group: groupMap.keys.firstWhere(
                          (k) => groupMap[k] == _groupList[index],
                          orElse: () => null)).then((value) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  });
                },
                title: Text(_groupList[index]),
              ),
            );
          }),
    );
  }
}
