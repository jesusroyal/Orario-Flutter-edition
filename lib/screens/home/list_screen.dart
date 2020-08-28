import 'package:flutter/material.dart';
import 'package:orario/screens/sectioned_list.dart';
import 'package:orario/services/setup_service.dart';
import 'package:orario/screens/home/list_screen/section_widget.dart';
import 'package:orario/screens/home/list_screen/list_widget.dart';
import 'package:orario/ui.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: OrarioColors.backGround,
      child: FlutterSectionListView(
        numberOfSection: () => 6,
        numberOfRowsInSection: (section) {
          return 7;
        },
        sectionWidget: (section) {
          return ListSection(section);
        },
        rowWidget: (section, row) {
          return ListWidget(
            lesson: SetupService.lessonDict['0/$section/$row'],
          );
        },
      ),
    );
  }
}
