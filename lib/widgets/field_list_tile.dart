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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isCurrency == true)
                    Text(
                      "${list[fieldIndex].flag!} ",
                      style: const TextStyle(fontSize: 20),
                    ),
                  Text(
                    list[fieldIndex].name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 18),
                  Text(
                    isCurrency == true
                        ? "(${list[fieldIndex].symbol})"
                        : "(${list[fieldIndex].id})",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 15,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          TextField(
            controller: controller,
            autofocus: isFieldSelected,
            showCursor: false,
            readOnly: true,
            keyboardType: TextInputType.none,
            style: TextStyle(
                fontSize: 24,
                color: isFieldSelected
                    ? Theme.of(context).colorScheme.primary
                    : null),
            decoration: const InputDecoration(border: InputBorder.none),
            onTap: () {
              onFieldSelect();
              // this is to place the cursor at the end of the text
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            },
          ),
        ],
      ),
    );
  }
}
