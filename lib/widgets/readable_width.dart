import 'package:flutter/material.dart';

/// Caps content at a readable line length on wide screens (tablets, landscape)
/// and keeps it clear of the notch on either side.
class ReadableWidth extends StatelessWidget {
  const ReadableWidth({super.key, required this.child});

  static const double maxWidth = 640;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
