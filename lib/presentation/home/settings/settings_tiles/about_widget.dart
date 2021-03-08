import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutSettingsTile extends StatelessWidget {
  const AboutSettingsTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width: 60.0, child: SvgPicture.asset('assets/logo.svg')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  child: AutoSizeText(
                    'Orario v0.0.6 Bloc edition',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
                Expanded(child: Text('Твой учебный ассистент!')),
                Expanded(child: Text('telegram: @shevelinsky')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
