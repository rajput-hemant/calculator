import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'scrollable_sheet.dart';

class FieldListTile extends StatelessWidget {
  final int index;
  final Widget child;
  final dynamic field;
  final bool isSelectedField;
  final String title, subtitle;
  final String bottomSheetHeader;
  final VoidCallback onTappingField;

  const FieldListTile({
    super.key,
    required this.index,
    required this.child,
    required this.field,
    required this.title,
    required this.subtitle,
    required this.onTappingField,
    required this.isSelectedField,
    required this.bottomSheetHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: const Color(0xFF171717),
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
        child: Text(
          title,
          maxLines: 1,
          style: kUnitTextStyle,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: GestureDetector(
        onTap: onTappingField,
        child: Text(
          field,
          style: TextStyle(
            fontSize: isSelectedField ? 32 : 24,
            color: isSelectedField ? Colors.blue[300] : Colors.white,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
