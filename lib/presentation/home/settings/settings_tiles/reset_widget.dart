import 'package:flutter/material.dart';

class ResetSettingsTile extends StatelessWidget {
  final GestureTapCallback onTap;

  const ResetSettingsTile({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Сброс настроек'),
            onTap: () {
              onTap();
            }));
  }
}
