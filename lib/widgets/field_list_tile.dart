import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/unit.dart';
import '../screens/select_unit_screen.dart';

class FieldListTile extends StatelessWidget {
  const FieldListTile({
    super.key,
    required this.controller,
    required this.list,
    this.isCurrency,
    required this.isFieldSelected,
    required this.isLabelSelected,
    required this.onFieldSelect,
    required this.onLabelSelect,
    required this.fieldIndex,
    required this.changeSelectedIndex,
  });

  final TextEditingController controller;
  final List<Unit> list;
  final bool? isCurrency;
  final bool isFieldSelected;
  final bool isLabelSelected;
  final VoidCallback onFieldSelect;
  final VoidCallback onLabelSelect;
  final int fieldIndex;
  final Function changeSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              onLabelSelect();
              final selectedIndex = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectUnitScreen(
                    list: list,
                    isCurrency: isCurrency,
                    selectedUnitIndex: fieldIndex,
                  ),
                ),
              );

              if (selectedIndex != null) {
                changeSelectedIndex(selectedIndex);
              }
            },
            child: Row(
              children: [
                if (isCurrency == true)
                  Text(
                    "${list[fieldIndex].flag!} ",
                    style: const TextStyle(fontSize: 20),
                  ),
                Text(
                  "${list[fieldIndex].name} (${isCurrency == true ? list[fieldIndex].symbol : list[fieldIndex].id})",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, fontFamily: ""),
                ),
                const SizedBox(width: 18),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 15,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: isFieldSelected,
              onTap: () {
                onFieldSelect();
                // this is to place the cursor at the end of the text
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
              },
              showCursor: false,
              readOnly: true,
              keyboardType: TextInputType.none,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 20, color: isFieldSelected ? Colors.amber : null),
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
