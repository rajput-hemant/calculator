import 'package:calculator/utils/constants.dart';
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
          size: 27,
          color: kWhiteColorText,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          textdata,
          style: kUnitTextStyle,
        )
      ],
    );
  }
}
