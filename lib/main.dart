import 'package:flutter/material.dart';
import 'package:orario/modules/welcome.dart';

void main() {
  runApp(Orario());
}

class Orario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: HomeScreen());
  }
}
