import 'package:flutter/material.dart';
import 'package:orario/services/setup_service.dart';
import 'package:orario/screens/sectioned_list.dart';

class ListScreen extends StatefulWidget {
  ListScreen({this.title});
  final String title;

  @override
  _ListSrceen createState() => _ListSrceen();
}

class _ListSrceen extends State<ListScreen> {
  /// ----#1
  List<List<String>> items = [
    ['Item 1', 'Item 2', 'Item 3'],
    ['Item 4', 'Item 5'],
    ['Item 6', 'Item 7', 'Item 8', 'Item 9'],
    ['Item 10', 'Item 11'],
    ['Item 12', 'Item 13'],
    ['Item 14', 'Item 15', 'Item 16'],
    ['Item 17', 'Item 18']
  ];

  @override
  Widget build(BuildContext context) {
    /// ----#2
    return Scaffold(
        appBar: AppBar(
          title: Text("ha?"),
        ),
        body: FlutterSectionListView(
          numberOfSection: () => 6,
          numberOfRowsInSection: (section) {
            return 3;
          },
          sectionWidget: (section) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Section $section'),
              ),
              color: Colors.grey,
            );
          },
          rowWidget: (section, row) {
            return Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(SetupService.didFinish == true
                    ? (SetupService.lessonDict["0/$section/$row"] != null
                        ? SetupService.lessonDict["0/$section/$row"].name
                        : "Нет пар")
                    : ("нет данных")),
              ),
            );
          },
        ));
  }
}
