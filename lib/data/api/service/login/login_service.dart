import 'package:firebase_database/firebase_database.dart';

class LoginService {
  final ref = FirebaseDatabase.instance.reference().child('uni');

  Future<Map<String, String>> getUniversities() async {
    Map<String, String> unilist;
    await ref.once().then((snapshot) {
      final Map<dynamic, dynamic> snapshotData = snapshot.value['unilist'];
      unilist = snapshotData.cast<String, String>();
    });
    return unilist;
  }
}
