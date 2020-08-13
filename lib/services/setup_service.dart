import 'package:firebase_database/firebase_database.dart';
import 'package:orario/services/lesson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupService {
  static var ref = FirebaseDatabase.instance.reference().child('uni');

  static List<String> univercityData = List<String>();
  static List<String> groupData = List<String>();

  static Map<String, String> _univercityDict = Map<String, String>();
  static Map<String, String> _groupDict = Map<String, String>();

  static var lessonDict = Map<String, Lesson>();

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
    print(_univercityDict);
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

  static var didFinish = false;

  static String _path;

  static void init({
    ready(bool needsLogin),
  }) {
    getPath();
    bool needsLogin;
    if (_path == null) {
      needsLogin = false;
      ready(needsLogin);
    } else {
      needsLogin = true;
      _getData(ready: ready(needsLogin));
    }
  }

  static void _getData({ready()}) {
    ref.child(_path).child('timetable');

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
      ready();
    });
  }

  static getPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('path');
    _path = stringValue;
  }

  static Future<void> setPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('path', _path);
  }

  static void setGroupTo({String group, ready()}) {
    _path += '/' + _groupDict[group];
    setPath();
    ref = ref.child(_groupDict[group]).child("timetable");
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
              print(lessonDict["$week/$day/$lesson"]);
            }
          }
        }
      }
      ready();
    });
  }
}
