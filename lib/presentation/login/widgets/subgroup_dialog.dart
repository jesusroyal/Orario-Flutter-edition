import 'package:flutter/material.dart';

class SubgroupDialog extends StatelessWidget {
  final Function(int) onSelect;

  const SubgroupDialog({Key key, @required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Подгруппа'),
      actions: [
        FlatButton(onPressed: () => onSelect(0), child: const Text('Первая')),
        FlatButton(onPressed: () => onSelect(1), child: const Text('Вторая'))
      ],
    );
  }
}
