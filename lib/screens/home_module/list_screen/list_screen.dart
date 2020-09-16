import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/settings_screen/edit_screen.dart';
import 'package:orario/screens/widgets/sectioned_list_widget.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/screens/widgets/section_widget.dart';
import 'package:orario/screens/widgets/list_widget.dart';
import 'package:orario/screens/ui_constants.dart';

class ListScreen extends StatefulWidget {
  final bool isEditor;

  const ListScreen({Key key, this.isEditor}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState(isEditor: isEditor);
}

class _ListScreenState extends State<ListScreen> {
  int currentWeek = 0;
  final bool isEditor;

  _ListScreenState({Key key, this.isEditor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        actions: [
          IconButton(
              icon: Text('A'),
              onPressed: () {
                setState(() {
                  currentWeek = 0;
                });
              }),
          IconButton(
              icon: Text('B'),
              onPressed: () {
                setState(() {
                  currentWeek = 1;
                });
              })
        ],
        title: Text(isEditor ? 'Редактирование' : 'Расписание'),
      ),
      floatingActionButton: isEditor
          ? FloatingActionButton(
              onPressed: () => OrarioService.updateChanges(),
              child: Icon(Icons.save),
            )
          : null,
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
              path: '$currentWeek/$section/$row',
              allowEdition: isEditor,
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditScreen(path: '$currentWeek/$section/$row'),
                    ));
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
