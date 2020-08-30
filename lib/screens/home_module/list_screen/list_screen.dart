import 'package:flutter/material.dart';
import 'package:orario/screens/widgets/sectioned_list_widget.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/screens/widgets/section_widget.dart';
import 'package:orario/screens/widgets/list_widget.dart';
import 'package:orario/screens/ui_constants.dart';

class ListScreen extends StatelessWidget {
  final bool isEditor;

  const ListScreen({Key key, this.isEditor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditor ? 'Редактирование' : 'Расписание'),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => OrarioService.updateChanges()),
      body: Container(
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
              path: '0/$section/$row',
              allowEdition: isEditor,
            );
          },
        ),
      ),
    );
  }
}
