import 'package:flutter/material.dart';
import 'package:orario/screens/sectioned_list.dart';
import 'package:orario/services/setup_service.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSectionListView(
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
    );
  }
}
