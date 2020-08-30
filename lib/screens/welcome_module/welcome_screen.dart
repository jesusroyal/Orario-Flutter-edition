import 'package:flutter/material.dart';
import 'package:orario/screens/widgets/loading_widget.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/screens/welcome_module/univercity_selection.dart';
import 'package:orario/services/orario_service.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Добро пожаловать в Orario!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Ваше персональный ассистент',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              Image(image: AssetImage('assets/orariologo.png')),
              Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: OrarioColors.darkAccent,
                  child: Text('Начать'),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return LoadingDialog();
                      },
                    );
                    OrarioService.fetchUniversities().then((uniMap) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UniversitySelection(
                                    uniMap: uniMap,
                                    isAddingGroup: false,
                                  )));
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              MaterialButton(
                child: Text('У меня есть токен!'),
                onPressed: () {
                  OrarioService.fetchUniversities().then((uniMap) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UniversitySelection(
                                  uniMap: uniMap,
                                  isAddingGroup: true,
                                )));
                  });
                },
              )
            ],
          )),
    );
  }
}
