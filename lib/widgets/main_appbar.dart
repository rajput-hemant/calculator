import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/preferences_provider.dart';
import '../routes/routes.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(prefrencesProvider);

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
        child: Image.asset("assets/images/app_icon.png"),
      ),
      title: const Text(
        'Calculator',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        if (!prefs.tabView)
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.unitConverterScreen);
            },
            icon: Image.asset(
              "assets/images/grid-light.png",
              width: 24,
              height: 24,
            ),
          ),
        PopupMenuButton(
          surfaceTintColor: prefs.darkMode
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.surface,
          onSelected: (String? item) {
            Navigator.pushNamed(context, "/${item!.toLowerCase()}-screen");
          },
          itemBuilder: (context) {
            return ["Settings", "About"].map((String item) {
              return PopupMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList();
          },
          elevation: 15,
          offset: Offset(0.0, AppBar().preferredSize.height),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        )
      ],
      bottom: prefs.tabView
          ? const TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  text: "Calculator",
                ),
                Tab(
                  text: "Exchange Rate",
                ),
                Tab(
                  text: "Unit Converter",
                ),
              ],
            )
          : null,
    );
  }
}
