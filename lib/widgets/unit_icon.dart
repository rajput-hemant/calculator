import 'package:calculator/utils/constants.dart';
import 'package:flutter/material.dart';

class UnitIcon extends StatelessWidget {
  final String textData;
  final IconData iconName;

  const UnitIcon({super.key, required this.textData, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconName,
          size: 27,
          color: kWhiteColorText,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          textData,
          style: kUnitTextStyle,
        )
      ],
    );
  }
}
