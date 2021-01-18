import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orario/internal/theme.dart';
import 'package:orario/presentation/login/university_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Orario',
                    style: OrarioUI.text.h1Bold,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Твой персональный \n ассистент',
                    style: OrarioUI.text.h3Light,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/logo.svg',
                width: 300.0,
              ),
              RaisedButton(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Выбрать ВУЗ',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversityPage()));
                },
                color: OrarioUI.colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
