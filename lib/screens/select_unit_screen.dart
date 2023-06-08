import 'package:flutter/material.dart';

import '../models/models.dart';

class SelectUnitScreen extends StatelessWidget {
  const SelectUnitScreen({
    super.key,
    required this.list,
    required this.selectedUnitIndex,
  });

  final List<Unit> list;
  final int selectedUnitIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Unit"),
      ),
      body: ListView(
        children: [
          for (var index = 0; index < list.length; index++)
            RadioListTile(
              value: index,
              groupValue: selectedUnitIndex,
              onChanged: (value) {
                Navigator.pop(context, value);
              },
              title: Text(list[index].name),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
        ],
      ),
    );
  }
}
