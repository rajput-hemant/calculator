import 'package:flutter/material.dart';

import '../routes/routes.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
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
          elevation: 30,
          offset: Offset(0.0, AppBar().preferredSize.height),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        )
      ],
      bottom: const TabBar(
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
      ),
    );
  }
}
