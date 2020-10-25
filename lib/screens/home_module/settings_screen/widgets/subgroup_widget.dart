import 'package:flutter/material.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/services/orario_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubgroupSettingsTile extends StatefulWidget {
  @override
  _SubgroupSettingsTileState createState() => _SubgroupSettingsTileState();
}

class _SubgroupSettingsTileState extends State<SubgroupSettingsTile> {
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
                    OrarioService.updateForNewSettings();
                    SharedPreferences.getInstance().then((sp) {
                      sp.setBool('subgroup', OrarioSettings.isSubgroup);
                    });
                  });
                }),
          ],
        ),
      ),
    );
  }
}