import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/settings_screen/widgets/tile_widgets.dart';

class SettingsScreen extends StatelessWidget {
  final List<Widget> tileList = [
    AboutSettingsTile(),
    ResetSettingsTile(),
    LessonEditSettingsTile(),
    TimeEditSettingsTile(),
    SubgroupSettingsTile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView.builder(
          itemCount: tileList.length,
          itemBuilder: (context, index) {
            return tileList[index];
          }),
    );
  }
}
