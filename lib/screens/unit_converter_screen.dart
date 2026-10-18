import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../routes/routes.dart';
import '../theme/app_icons.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../widgets/glass.dart';
import '../widgets/grouped_list.dart';
import '../widgets/readable_width.dart';
import '../widgets/top_bar.dart';

/// One Convert hub entry: what it is, its icon and where it opens.
class _Category {
  const _Category(this.icon, {required this.units});

  final IconData icon;
  final Units units;

  String get label => units.label;

  bool get isCurrency => units == Units.currency;

  String get count => '${units.units.length}';
}

const List<_Category> _categories = [
  _Category(AppIcons.currencyExchange, units: Units.currency),
  _Category(AppIcons.convert, units: Units.length),
  _Category(AppIcons.thermostat, units: Units.temperature),
  _Category(AppIcons.scale, units: Units.weight),
  _Category(AppIcons.squareFoot, units: Units.area),
  _Category(AppIcons.waterDrop, units: Units.volume),
  _Category(AppIcons.speed, units: Units.speed),
  _Category(AppIcons.storage, units: Units.data),
  _Category(AppIcons.bolt, units: Units.power),
  _Category(AppIcons.localFireDepartment, units: Units.energy),
  _Category(AppIcons.compress, units: Units.pressure),
  _Category(AppIcons.schedule, units: Units.time),
  _Category(AppIcons.architecture, units: Units.planeAngle),
  _Category(AppIcons.graphicEq, units: Units.frequency),
  _Category(AppIcons.localGasStation, units: Units.fuel),
];

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  String _query = '';

  void _open(_Category category) {
    if (category.isCurrency) {
      Navigator.pushNamed(context, Routes.exchangeRateScreen);
    } else {
      Navigator.pushNamed(
        context,
        Routes.conversionScreen,
        arguments: category.units,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final query = _query.trim().toLowerCase();
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    // The search bar rides above the keyboard. The Scaffold does not resize
    // for it, so the list keeps its place behind the bar.
    final barBottom = math.max(
      MediaQuery.viewInsetsOf(context).bottom,
      safeBottom,
    );

    final visible = _categories
        .where((category) => category.label.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: p.grouped,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const TopBar(),
      body: ReadableWidth(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(
                top: Tokens.topBarInset(context),
                bottom: Gaps.sm + Tokens.control + Gaps.sm + safeBottom,
              ),
              children: [
                const LargeTitle('Convert'),
                if (visible.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(Gaps.huge),
                    child: Text(
                      'No categories found',
                      textAlign: TextAlign.center,
                      style: AppText.body.copyWith(color: p.label2),
                    ),
                  )
                else
                  InsetGroup(
                    children: [
                      for (final category in visible)
                        GroupCell(
                          title: category.label,
                          leading: IconTile(category.icon),
                          trailing: Text(category.count),
                          chevron: true,
                          onTap: () => _open(category),
                        ),
                    ],
                  ),
              ],
            ),
            Positioned(
              left: Gaps.lg,
              right: Gaps.lg,
              bottom: barBottom + Gaps.sm,
              child: Glass(
                child: SizedBox(
                  height: Tokens.control,
                  child: TextField(
                    onChanged: (text) => setState(() => _query = text),
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: AppText.body.copyWith(color: p.label),
                    decoration: InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      isCollapsed: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 8),
                        child: Icon(AppIcons.search, size: 18, color: p.label2),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      // Mirrors the search icon so text centers on the bar.
                      suffixIcon: const SizedBox(width: 40),
                      suffixIconConstraints: const BoxConstraints(),
                      hintText: 'Search ${_categories.length} categories',
                      hintStyle: AppText.body.copyWith(color: p.label2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
