import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';

class UnitIcon extends StatelessWidget {
  const UnitIcon(this.iconname, this.textdata);

  final String textdata;
  final IconData iconname;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconname,
          size: 35,
          color: kWhiteColorText,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          textdata,
          style: kUnitTextStyle,
        )
      ],
    );
  }
}
