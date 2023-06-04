import 'package:flutter/material.dart';

import '../models/models.dart';

class SelectUnitScreen extends StatefulWidget {
  const SelectUnitScreen({
    super.key,
    required this.list,
  });

  final List<Unit> list;

  @override
  State<SelectUnitScreen> createState() => _SelectUnitScreenState();
}

class _SelectUnitScreenState extends State<SelectUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Unit"),
      ),
      body: Column(
        children: [
          for (var unit in widget.list)
            RadioListTile(
              value: unit.id,
              groupValue: null,
              onChanged: (value) {
                Navigator.pop(context, value);
              },
              title: Text(unit.name),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
        ],
      ),
    );
  }
}
