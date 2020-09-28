import 'package:flutter/material.dart';
import 'package:orario/services/orario_settings.dart';

class SubgroupTile extends StatefulWidget {
  @override
  _SubgroupTileState createState() => _SubgroupTileState();
}

class _SubgroupTileState extends State<SubgroupTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Вторая подгруппа'),
            Switch(
                value: OrarioSettings.isSubgroup,
                onChanged: (value) {
                  setState(() {
                    OrarioSettings.isSubgroup = value;
                    print(value);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
