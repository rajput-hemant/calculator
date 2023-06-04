import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/unit.dart';

class FieldListTile extends StatelessWidget {
  const FieldListTile({
    super.key,
    required this.controller,
    required this.list,
    required this.isSelected,
    required this.fieldIndex,
    required this.onSelect,
  });

  final TextEditingController controller;
  final List<Unit> list;
  final bool isSelected;
  final int fieldIndex;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "${list[fieldIndex].name} (${list[fieldIndex].id})",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      title: const Icon(
        FontAwesomeIcons.chevronRight,
        size: 15,
        color: Colors.grey,
      ),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: TextField(
          controller: controller,
          autofocus: isSelected,
          onTap: () {
            onSelect();
            // this is to place the cursor at the end of the text
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          },
          showCursor: false,
          readOnly: true,
          keyboardType: TextInputType.none,
          textAlign: TextAlign.right,
          style:
              TextStyle(fontSize: 20, color: isSelected ? Colors.amber : null),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
