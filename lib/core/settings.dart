import 'package:shared_preferences/shared_preferences.dart';

class OrarioSettings {
  String path = null;
  bool isSubGroup = null;

  Future<void> retriv() async {
    var prefs = await SharedPreferences.getInstance();

    path = prefs.getString('DBPath');
    isSubGroup = prefs.getBool('subgroup');
  }
}
