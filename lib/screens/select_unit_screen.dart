import 'package:flutter/material.dart';

import '../models/models.dart';

class SelectUnitScreen extends StatelessWidget {
  const SelectUnitScreen({
    super.key,
    required this.list,
    required this.selectedUnitIndex,
    this.isCurrency,
  });

  final List<Unit> list;
  final int selectedUnitIndex;
  final bool? isCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select ${isCurrency == true ? "Currency" : "Unit"}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
              title: Text(
                "${isCurrency == true ? "${list[index].flag} " : ""}${list[index].name} (${list[index].id})",
              ),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
        ],
      ),
    );
  }
}
