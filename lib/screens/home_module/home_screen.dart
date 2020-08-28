import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/list_screen/list_screen.dart';
import 'package:orario/screens/home_module/settings_screen/settings_screen.dart';

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final tabs = [
    Center(
      child: Text("Дома"),
    ),
    ListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Сейчас")),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("Список")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Настройки")),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
