import 'package:firebase_database/firebase_database.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class OrarioService {
  static String _path;
  static Map<String, Lesson> lessonDict = {};

  static Future<bool> setupApp() async {
    bool needsLogin;
    await SharedPreferences.getInstance().then((sp) async {
      _path = sp.getString('DBPath');
      if (_path == null) {
        needsLogin = true;
      } else {
        await _getData().then((value) {
          needsLogin = false;
        });
      }
    });
    return needsLogin;
  }

  static Future<Map<String, String>> fetchUniversities() async {
    final ref = FirebaseDatabase.instance.reference().child('uni');
    Map<String, String> unilist;
    await ref.once().then((snapshot) {
      final Map<dynamic, dynamic> snapshotData = snapshot.value['unilist'];
      unilist = snapshotData.cast<String, String>();
    });
    return unilist;
  }

  static Future<Map<String, String>> fetchGroupsFor({String university}) async {
    _path = '$university/';
    Map<String, String> grouplist;
    final ref = FirebaseDatabase.instance.reference().child('uni/$university');

    await ref.once().then((snapshot) {
      final Map<dynamic, dynamic> snapshotData = snapshot.value['grouplist'];
      grouplist = snapshotData.cast<String, String>();
    });
    return grouplist;
  }

  static Future<Map<String, String>> fetchTokensFor({String university}) async {
    _path = '$university/';
    Map<String, String> tokenlist;
    final ref = FirebaseDatabase.instance.reference().child('uni/$university');

    await ref.once().then((snapshot) {
      final Map<dynamic, dynamic> snapshotData = snapshot.value['tokens'];
      tokenlist = snapshotData.cast<String, String>();
    });
    return tokenlist;
  }

  static Future<void> setupGroup(
      {String group, String title, String token}) async {
    final ref = FirebaseDatabase.instance.reference().child('uni/$_path');
    await ref.child('grouplist').update({group: title});
    await ref.child('tokens').update({group: null});

    ref.child('$group/token').set(token);

    for (int week = 0; week <= 1; week++) {
      for (int day = 0; day <= 6; day++) {
        for (int lesson = 0; lesson <= 7; lesson++) {
          ref.child('$group/timetable/$week/$day/$lesson').set('no');
        }
      }
    }
    _path += group;
    await _getData();
    return;
  }

  static Future<void> fetchDataFor({String group}) async {
    _path += group;

    SharedPreferences.getInstance().then((sp) {
      sp.setString('DBPath', _path);
    });

    await _getData().then((value) {
      return;
    });
  }

  static Future<void> _getData() async {
    final db = FirebaseDatabase.instance;

    db.setPersistenceEnabled(true);
    db.setPersistenceCacheSizeBytes(10000000);

    final ref = db.reference().child('uni/$_path/timetable');

    await ref.once().then((snapshot) {
      for (int week = 0; week < 2; week++) {
        for (int day = 0; day < snapshot.value[week].length; day++) {
          for (int lesson = 0;
              lesson < snapshot.value[week][day].length;
              lesson++) {
            if (snapshot.value[week][day][lesson] != 'no') {
              var data = snapshot.value[week][day][lesson];
              lessonDict["$week/$day/$lesson"] = Lesson.fromDynamicMap(data);
            }
          }
        }
      }
    });
    return;
  }

  static Future<bool> verify({String token}) async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/$_path/token');

    bool isValid = false;
    await ref.once().then((value) {
      if (value.value.toString() == token) {
        isValid = true;
      }
    });
    return isValid;
  }

  static Future<void> updateChanges() async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/$_path/timetable');
    print(_path);
    // ref.set({'test': 'i work'}).catchError((e) => print('error $e'));

    for (int week = 0; week <= 2; week++) {
      for (int day = 0; day <= 6; day++) {
        for (int lesson = 0; lesson <= 8; lesson++) {
          if (lessonDict['$week/$day/$lesson'] == null) {
            ref
                .child(week.toString())
                .child(day.toString())
                .update({'$lesson': 'no'});
          } else {
            ref
                .child(week.toString())
                .child(day.toString())
                .child(lesson.toString())
                .set({
              'name': lessonDict['$week/$day/$lesson'].name,
              'location': lessonDict['$week/$day/$lesson'].location,
              'don': lessonDict['$week/$day/$lesson'].don,
              'type': lessonDict['$week/$day/$lesson'].type.index,
            });
          }
          ;
        }
      }
    }
  }

  static Future<void> resetSettings() async {
    final db = FirebaseDatabase.instance;

    await db.setPersistenceEnabled(false);
    lessonDict.clear();
    await SharedPreferences.getInstance().then((sp) {
      sp.clear();
    });
  }

  // static FirebaseDatabase database = FirebaseDatabase.instance;

  // static var ref = database.reference().child('uni');

  // static String _path;
  // static var lessonDict = Map<String, Lesson>();

  // static void init({
  //   ready(bool needsLogin),
  // }) {
  //   SharedPreferences.getInstance().then((sp) {
  //     var sharedPreferences = sp;
  //     _path = sharedPreferences.getString('DBPath');
  //     bool needsLogin;
  //     if (_path == null) {
  //       needsLogin = false;
  //       ready(needsLogin);
  //     } else {
  //       needsLogin = true;
  //       _getData(ready: ready(needsLogin));
  //     }
  //   });
  // }

  // static void getPath() {
  //   SharedPreferences.getInstance().then((sp) {
  //     var sharedPreferences = sp;
  //     _path = sharedPreferences.getString('DBPath');
  //   });
  // }

  // static Future setPath() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('DBPath', _path);
  // }

  // static List<String> univercityData = List<String>();
  // static List<String> groupData = List<String>();

  // static Map<String, String> _univercityDict = Map<String, String>();
  // static Map<String, String> _groupDict = Map<String, String>();

  // static void getUnivercityData({ready()}) {
  //   univercityData.clear();
  //   ref.once().then((snapshot) {
  //     Map<dynamic, dynamic> unilist = snapshot.value['unilist'];
  //     unilist.forEach((key, value) {
  //       univercityData.add(value.toString());
  //       _univercityDict[value.toString()] = key.toString();
  //     });
  //     ready();
  //   });
  // }

  // static void getGroupDataFor({String univercity, ready()}) {
  //   groupData.clear();
  //   _path = _univercityDict[univercity];
  //   ref = FirebaseDatabase.instance.reference().child('uni').child(_path);
  //   print(_path);
  //   ref.once().then((snapshot) {
  //     Map<dynamic, dynamic> grouplist = snapshot.value['grouplist'];
  //     grouplist.forEach((key, value) {
  //       groupData.add(value.toString());
  //       _groupDict[value.toString()] = key.toString();
  //     });
  //     ready();
  //   });
  // }

  // static void setGroupTo({String group, ready()}) {
  //   _path += '/' + _groupDict[group];
  //   setPath().then((value) {
  //     ref.child(_groupDict[group]).child("timetable").once().then((snapshot) {
  //       for (int week = 0; week < 2; week++) {
  //         for (int day = 0;
  //             day < snapshot.value[week.toString()].length;
  //             day++) {
  //           for (int lesson = 0;
  //               lesson < snapshot.value[week.toString()][day].length;
  //               lesson++) {
  //             if (snapshot.value[week.toString()][day][lesson] != null) {
  //               var data = snapshot.value[week.toString()][day][lesson];
  //               lessonDict["$week/$day/$lesson"] = Lesson.fromDynamicMap(data);
  //               print(lessonDict["$week/$day/$lesson"]);
  //             }
  //           }
  //         }
  //       }
  //       ready();
  //     });
  //   });
  // }

  // static void _getData({ready()}) {
  //   database = FirebaseDatabase.instance;
  //   database.setPersistenceEnabled(true);
  //   database.setPersistenceCacheSizeBytes(10000000);

  //   ref.child(_path).child('timetable');

  //   ref = FirebaseDatabase.instance
  //       .reference()
  //       .child('uni')
  //       .child(_path)
  //       .child('timetable');

  //   ref.once().then((snapshot) {
  //     for (int week = 0; week < 2; week++) {
  //       for (int day = 0; day < snapshot.value[week.toString()].length; day++) {
  //         for (int lesson = 0;
  //             lesson < snapshot.value[week.toString()][day].length;
  //             lesson++) {
  //           if (snapshot.value[week.toString()][day][lesson] != null) {
  //             var data = snapshot.value[week.toString()][day][lesson];
  //             lessonDict["$week/$day/$lesson"] = Lesson.fromDynamicMap(data);
  //           }
  //         }
  //       }
  //     }
  //     if (ready != null) {
  //       ready();
  //     }
  //   });
  // }
}
