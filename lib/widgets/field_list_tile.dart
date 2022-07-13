import 'package:flutter/material.dart';

import 'scrollable_sheet.dart';

class FieldListTile extends StatelessWidget {
  final int index;
  final List list;
  final Widget child;
  final dynamic field;
  final String fieldTitle;
  final String bottomSheetHeader;
  final VoidCallback onTappingField;

  const FieldListTile({
    super.key,
    required this.index,
    required this.field,
    required this.fieldTitle,
    required this.onTappingField,
    required this.list,
    required this.child,
    required this.bottomSheetHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        child: Text(fieldTitle),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (_) {
              return ScrollableSheet(
                sheetHeader: bottomSheetHeader,
                listViewBuilder: child,
              );
            },
          );
        },
      ),
      subtitle: Text(list[index].id),
      trailing: InkWell(
        onTap: onTappingField,
        child: Text(
          field,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
