import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orario/services/lesson.dart';

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
      ready();
    });
  }

  static var didFinish = false;

  static void setGroupTo({String group, ready()}) {
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
              lessonDict["$week/$day/$lesson"] = Lesson(
                  data["name"].toString(),
                  data["location"].toString(),
                  data["don"].toString(),
                  int.parse(data["type"].toString()));
            }
          }
        }
      }
      ready();
    });
  }
}
