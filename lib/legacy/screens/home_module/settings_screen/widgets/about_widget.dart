import 'package:flutter/material.dart';

class AboutSettingsTile extends StatelessWidget {
  const AboutSettingsTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: 70.0,
        child: Row(
          children: [
            Image(image: AssetImage('assets/orariologo.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Orario v0.0.5 Homejoy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                Text('Твой учебный ассистент!'),
                Text('telegram: @shevelinsky'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
