import 'package:firebase_database/firebase_database.dart';
import 'package:orario/services/lesson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupService {
  static var ref = FirebaseDatabase.instance.reference().child('uni');

  static String _path;
  static var lessonDict = Map<String, Lesson>();

  static void init({
    ready(bool needsLogin),
  }) {
    SharedPreferences.getInstance().then((sp) {
      var sharedPreferences = sp;
      _path = sharedPreferences.getString('DBPath');
      print(_path);
      bool needsLogin;
      if (_path == null) {
        needsLogin = false;
        ready(needsLogin);
      } else {
        needsLogin = true;
        _getData(ready: ready(needsLogin));
      }
    });
  }

  static void getPath() {
    SharedPreferences.getInstance().then((sp) {
      var sharedPreferences = sp;
      _path = sharedPreferences.getString('DBPath');
    });
    print(_path);
  }

  static Future setPath() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('DBPath', _path);
  }

  static List<String> univercityData = List<String>();
  static List<String> groupData = List<String>();

  static Map<String, String> _univercityDict = Map<String, String>();
  static Map<String, String> _groupDict = Map<String, String>();

  static void getUnivercityData({ready()}) {
    univercityData.clear();
    ref.once().then((snapshot) {
      Map<dynamic, dynamic> unilist = snapshot.value['unilist'];
      unilist.forEach((key, value) {
        univercityData.add(value.toString());
        _univercityDict[value.toString()] = key.toString();
      });
      ready();
    });
  }

  static void getGroupDataFor({String univercity, ready()}) {
    groupData.clear();
    _path = _univercityDict[univercity];
    ref = FirebaseDatabase.instance.reference().child('uni').child(_path);
    print(_path);
    ref.once().then((snapshot) {
      Map<dynamic, dynamic> grouplist = snapshot.value['grouplist'];
      grouplist.forEach((key, value) {
        groupData.add(value.toString());
        _groupDict[value.toString()] = key.toString();
      });
      ready();
    });
  }

  static void setGroupTo({String group, ready()}) {
    _path += '/' + _groupDict[group];
    setPath().then((value) {
      ref.child(_groupDict[group]).child("timetable").once().then((snapshot) {
        for (int week = 0; week < 2; week++) {
          for (int day = 0;
              day < snapshot.value[week.toString()].length;
              day++) {
            for (int lesson = 0;
                lesson < snapshot.value[week.toString()][day].length;
                lesson++) {
              if (snapshot.value[week.toString()][day][lesson] != null) {
                var data = snapshot.value[week.toString()][day][lesson];
                print(data);
                lessonDict["$week/$day/$lesson"] = Lesson.fromDynamicMap(data);
                print(lessonDict["$week/$day/$lesson"]);
              }
            }
          }
        }
        ready();
      });
    });
  }

  static void _getData({ready()}) {
    ref.child(_path).child('timetable');

    ref = FirebaseDatabase.instance
        .reference()
        .child('uni')
        .child(_path)
        .child('timetable');

    ref.once().then((snapshot) {
      for (int week = 0; week < 2; week++) {
        for (int day = 0; day < snapshot.value[week.toString()].length; day++) {
          for (int lesson = 0;
              lesson < snapshot.value[week.toString()][day].length;
              lesson++) {
            if (snapshot.value[week.toString()][day][lesson] != null) {
              var data = snapshot.value[week.toString()][day][lesson];
              print(data);
              lessonDict["$week/$day/$lesson"] = Lesson.fromDynamicMap(data);
            }
          }
        }
      }
      if (ready != null) {
        ready();
      }
    });
  }
}
