import 'package:firebase_database/firebase_database.dart';

class SetupService {
  static var ref = FirebaseDatabase.instance.reference().child('uni');

  static List<String> univercityData = ["БрГТУ", "БНТУ"];

  void getData() {
    univercityData.clear();
    ref.once().then((snapshot) {
      Map<dynamic, dynamic> unilist = snapshot.value['unilist'];
      print(unilist);
      unilist.forEach((key, value) {
        univercityData.add(value.toString());
      });
    });
  }
}
