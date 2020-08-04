import 'package:firebase_database/firebase_database.dart';
import 'package:orario/services/lesson.dart';

class SetupService {
  static var ref = FirebaseDatabase.instance.reference().child('uni');

  static List<String> univercityData = List<String>();
  static List<String> groupData = List<String>();

  static Map<String, String> _univercityDict = Map<String, String>();
  static Map<String, String> _groupDict = Map<String, String>();

  static Map<int, Map<int, Map<int, Lesson>>> lessonTable =
      Map<int, Map<int, Map<int, Lesson>>>();

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

  static void setGroupTo(String group) {
    ref = ref.child(_groupDict[group]).child("timetable");
    ref.once().then((value) => print(value.value));
    ref.once().then((snapshot) {
      for (int week = 0; week < 2; week++) {
        for (int day = 0; day < 7; day++) {
          for (int lesson = 0; lesson < 6; lesson++) {
            if (snapshot.value[
                    "${week.toString()}/${day.toString()}/${lesson.toString()}/name"] !=
                null) {
              lessonTable[week][day][lesson] = Lesson(
                snapshot.value[
                        "${week.toString()}/${day.toString()}/${lesson.toString()}/name"]
                    .toString(),
                snapshot.value[
                        "${week.toString()}/${day.toString()}/${lesson.toString()}/location"]
                    .toString(),
                snapshot.value[
                        "${week.toString()}/${day.toString()}/${lesson.toString()}/don"]
                    .toString(),
                int.parse(snapshot.value[
                        "${week.toString()}/${day.toString()}/${lesson.toString()}/type"]
                    .toString()),
              );
              print(lessonTable[week][day][lesson]);
            }
          }
        }
      }
    });

    print(lessonTable);
  }
}
