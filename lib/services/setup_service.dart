import 'package:firebase_database/firebase_database.dart';

class SetupService {
  static var ref = FirebaseDatabase.instance.reference().child('uni');

  static List<String> univercityData = List<String>();
  static List<String> groupData = List<String>();

  static Map<String, String> _univercityDict = Map<String, String>();
  static Map<String, String> _groupDict = Map<String, String>();

  static void getUnivercityData() {
    ref.once().then((snapshot) {
      Map<dynamic, dynamic> unilist = snapshot.value['unilist'];
      unilist.forEach((key, value) {
        univercityData.add(value.toString());
        _univercityDict[value.toString()] = key.toString();
      });
    });
    print(_univercityDict);
  }

  static void getGroupData(String univercity) {
    print(univercity);
    var univercityPath = _univercityDict[univercity];
    ref = FirebaseDatabase.instance
        .reference()
        .child('uni')
        .child(univercityPath);
    print(univercityPath);
    ref.once().then((snapshot) {
      Map<dynamic, dynamic> grouplist = snapshot.value['grouplist'];
      grouplist.forEach((key, value) {
        groupData.add(value.toString());
        _groupDict[value.toString()] = key.toString();
      });
    });
  }
}
