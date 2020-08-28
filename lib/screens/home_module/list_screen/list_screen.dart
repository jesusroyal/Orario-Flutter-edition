import 'package:flutter/material.dart';
import 'package:orario/screens/widgets/sectioned_list_widget.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/screens/widgets/section_widget.dart';
import 'package:orario/screens/widgets/list_widget.dart';
import 'package:orario/screens/ui_constants.dart';

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
            lesson: OrarioService.lessonDict['0/$section/$row'],
          );
        },
      ),
    );
  }
}
