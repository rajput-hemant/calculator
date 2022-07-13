import 'package:flutter/material.dart';

class BottomSheetTile extends StatelessWidget {
  final List list;
  final int index;
  final VoidCallback onSelecting;

  const BottomSheetTile({
    super.key,
    required this.list,
    required this.index,
    required this.onSelecting,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: onSelecting,
        child: Text(list[index].name),
      ),
    );
  }
}
