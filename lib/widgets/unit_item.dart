import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final FaIconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      onPressed: onPressed,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }
}
