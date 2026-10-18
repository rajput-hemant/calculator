import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../theme/app_icons.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import 'glass.dart';

/// The calculator's top bar: History on the left, and Convert, the scientific
/// toggle and More on the right.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.showScientific = false,
    this.onScientificToggle,
  });

  final bool showScientific;
  final VoidCallback? onScientificToggle;

  @override
  Size get preferredSize => const Size.fromHeight(Tokens.topBarHeight);

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return GlassTopBar(
      leading: GlassAction(
        icon: AppIcons.history,
        tooltip: 'History',
        onPressed: () => Navigator.pushNamed(context, Routes.historyScreen),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlassAction(
            icon: AppIcons.convert,
            tooltip: 'Convert',
            onPressed: () =>
                Navigator.pushNamed(context, Routes.unitConverterScreen),
          ),
          if (onScientificToggle != null)
            GlassAction(
              icon: AppIcons.scientific,
              tooltip: 'Scientific functions',
              selected: showScientific,
              onPressed: onScientificToggle,
            ),
          PopupMenuButton<String>(
            tooltip: 'More options',
            padding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            onSelected: (route) => Navigator.pushNamed(context, route),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: Routes.settingsScreen,
                child: Text('Settings'),
              ),
              PopupMenuItem(value: Routes.aboutScreen, child: Text('About')),
            ],
            child: SizedBox.square(
              dimension: Tokens.glassControl,
              child: Icon(AppIcons.more, size: 24, color: p.label2),
            ),
          ),
        ],
      ),
    );
  }
}
