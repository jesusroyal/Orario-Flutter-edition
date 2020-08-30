import 'package:flutter/material.dart';
import 'package:orario/screens/welcome_module/token_verification_screen.dart';
import 'package:orario/screens/widgets/loading_widget.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/screens/welcome_module/group_selection.dart';

class UniversitySelection extends StatelessWidget {
  final bool isAddingGroup;
  final Map<String, String> uniMap;
  final List<String> _uniList = [];

  UniversitySelection({this.uniMap, this.isAddingGroup}) {
    uniMap.forEach((key, value) {
      _uniList.add(value);
    });
  }

  void _goToGroup({BuildContext context, int index}) {
    showDialog(context: context, builder: (context) => LoadingDialog());

    OrarioService.fetchGroupsFor(
        university: uniMap.keys.firstWhere((k) => uniMap[k] == _uniList[index],
            orElse: () => null)).then((groupMap) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupSelection(
                    groupMap: groupMap,
                  )));
    });
  }

  void _goToTokenVerification({BuildContext context, int index}) {
    showDialog(context: context, builder: (context) => LoadingDialog());

    OrarioService.fetchTokensFor(
        university: uniMap.keys.firstWhere((k) => uniMap[k] == _uniList[index],
            orElse: () => null)).then((tokenMap) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TokenVerification(tokenMap: tokenMap)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrarioColors.backGround,
      appBar: AppBar(
        backgroundColor: OrarioColors.darkAccent,
        title: Text('Выберите ваш ВУЗ'),
      ),
      body: ListView.builder(
          itemCount: _uniList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  if (isAddingGroup) {
                    _goToTokenVerification(index: index, context: context);
                  } else {
                    _goToGroup(index: index, context: context);
                  }
                },
                title: Text(_uniList[index]),
              ),
            );
          }),
    );
  }
}
