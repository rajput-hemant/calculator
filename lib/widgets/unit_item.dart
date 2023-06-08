import 'package:flutter/material.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
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
          Icon(icon),
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
