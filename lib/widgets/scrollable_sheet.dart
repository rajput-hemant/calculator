import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScrollableSheet extends StatelessWidget {
  final Widget listViewBuilder;
  final String sheetHeader;

  const ScrollableSheet(
      {super.key, required this.listViewBuilder, required this.sheetHeader});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.25,
      initialChildSize: 0.95,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FontAwesomeIcons.gripLines,
                size: 20,
                color: Colors.grey,
              ),
              const Divider(),
              Text(
                sheetHeader,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(child: listViewBuilder),
            ],
          ),
        );
      },
    );
  }
}
