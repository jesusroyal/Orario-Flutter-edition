import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

class LoginService {
  final ref = FirebaseDatabase.instance.reference().child('uni');

  Future<Map<String, String>> getUniversities() async {
    Map<String, String> unilist;
    await ref.once().then((snapshot) {
      final Map<dynamic, dynamic> snapshotData =
          snapshot.value['unilist'] as Map<dynamic, dynamic>;
      unilist = snapshotData.cast<String, String>();
    });
    return unilist;
  }

  Future<Map<String, String>> getGroups({@required String university}) async {
    Map<String, String> grouplist;

    await ref.child(university).once().then((snapshot) {
      final Map<dynamic, dynamic> snapshotData =
          snapshot.value['grouplist'] as Map<dynamic, dynamic>;
      grouplist = snapshotData.cast<String, String>();
    });
    return grouplist;
  }
}
