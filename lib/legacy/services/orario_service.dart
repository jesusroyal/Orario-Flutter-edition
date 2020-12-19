import 'package:firebase_database/firebase_database.dart';
import 'package:orario/data/api/model/lesson.dart';
import 'package:orario/services/orario_settings.dart';
import 'package:orario/data/api/model/time.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class OrarioService {
  static String _path;
  static Map<String, Lesson> lessonDict = {};
  static List<TimeMoment> timeDict = List<TimeMoment>.filled(8, null);

  static Future<bool> setupApp() async {
    bool needsLogin;
    await SharedPreferences.getInstance().then((sp) async {
      _path = sp.getString('DBPath');
      if (_path == null) {
        needsLogin = true;
        sp.setBool('subgroup', false);
      } else {
        bool _subgroup = sp.getBool('subgroup');
        OrarioSettings.isSubgroup = _subgroup;
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

    for (int week = 0; week <= 3; week++) {
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
    int weekStart = OrarioSettings.isSubgroup ? 2 : 0;
    int weekEnd = OrarioSettings.isSubgroup ? 3 : 1;

    var ref = db.reference().child('uni/$_path/timetable');

    await ref.once().then((snapshot) {
      for (int week = weekStart; week <= weekEnd; week++) {
        for (int day = 0; day < snapshot.value[week].length; day++) {
          for (int lesson = 0;
              lesson < snapshot.value[week][day].length;
              lesson++) {
            if (snapshot.value[week][day][lesson] != 'no') {
              var data = snapshot.value[week][day][lesson];
              lessonDict[
                      "${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson"] =
                  Lesson.fromDynamicMap(data);
            } else {
              lessonDict[
                      "${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson"] =
                  null;
            }
          }
        }
      }
    });

    ref = db.reference().child('uni/${_path.split('/')[0]}/time');

    await ref.once().then((snapshot) {
      for (int lesson = 0; lesson < 8; lesson++) {
        if (snapshot.value[lesson] != 'no') {
          var data = snapshot.value[lesson];
          timeDict[lesson] = TimeMoment.fromDynamicMap(data);
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
    int weekStart = OrarioSettings.isSubgroup ? 2 : 0;
    int weekEnd = OrarioSettings.isSubgroup ? 3 : 1;
    final ref = db.reference().child('uni/$_path/timetable');

    for (int week = weekStart; week <= weekEnd; week++) {
      for (int day = 0; day <= 6; day++) {
        for (int lesson = 0; lesson <= 8; lesson++) {
          if (lessonDict[
                  '${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson'] ==
              null) {
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
              'name': lessonDict[
                      '${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson']
                  .name,
              'location': lessonDict[
                      '${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson']
                  .location,
              'don': lessonDict[
                      '${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson']
                  .don,
              'type': lessonDict[
                      '${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson']
                  .type
                  .index,
            });
          }
        }
      }
    }
  }

  static Future<void> saveTimeTable() async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/${_path.split('/')[0]}/time');
    for (int lesson = 0; lesson < 8; lesson++) {
      if (timeDict[lesson] != null) {
        if (lesson < 7) {
          if (timeDict[lesson + 1] != null) {
            timeDict[lesson].breakDuration =
                timeDict[lesson + 1].startInt - timeDict[lesson].endInt;
          }
        }

        await ref.child(lesson.toString()).update(timeDict[lesson].FBDict);
      }
    }
    return;
  }

  static Future<void> resetSettings() async {
    final db = FirebaseDatabase.instance;

    await db.setPersistenceEnabled(false);
    lessonDict.clear();
    timeDict = List<TimeMoment>.filled(8, null);
    await SharedPreferences.getInstance().then((sp) {
      sp.clear();
    });
  }

  static Future<void> updateForNewSettings() async {
    final db = FirebaseDatabase.instance;

    db.setPersistenceEnabled(true);
    db.setPersistenceCacheSizeBytes(10000000);
    lessonDict.clear();
    int weekStart = OrarioSettings.isSubgroup ? 2 : 0;
    int weekEnd = OrarioSettings.isSubgroup ? 3 : 1;
    var ref = db.reference().child('uni/$_path/timetable');

    await ref.once().then((snapshot) {
      for (int week = weekStart; week <= weekEnd; week++) {
        for (int day = 0; day < snapshot.value[week].length; day++) {
          for (int lesson = 0;
              lesson < snapshot.value[week][day].length;
              lesson++) {
            if (snapshot.value[week][day][lesson] != 'no') {
              var data = snapshot.value[week][day][lesson];
              lessonDict[
                      "${OrarioSettings.isSubgroup ? week - 2 : week}/$day/$lesson"] =
                  Lesson.fromDynamicMap(data);
            }
          }
        }
      }
    });
  }
}
