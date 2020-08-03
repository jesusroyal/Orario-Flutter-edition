import 'package:flutter/material.dart';
import 'package:orario/modules/welcome.dart';
import 'package:orario/services/setup_service.dart';

void main() {
  // SetupService().getData();
  runApp(Orario());
}

class Orario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SetupService().getData();
    return new MaterialApp(home: HomeScreen());
  }
}
