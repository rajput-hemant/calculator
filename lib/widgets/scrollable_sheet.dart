import 'package:flutter/material.dart';

class ScrollableSheet extends StatelessWidget {
  final Widget listViewBuilder;
  final String sheetHeader;

  const ScrollableSheet(
      {super.key, required this.listViewBuilder, required this.sheetHeader});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.95,
      initialChildSize: 0.9,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                sheetHeader,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              listViewBuilder,
            ],
          ),
        );
      },
    );
  }
}
