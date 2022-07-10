import 'package:flutter/material.dart';

class UnitBox extends StatelessWidget {
  const UnitBox(this.icondata, this.iconfunction);

  final Widget icondata;
  final VoidCallback iconfunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: iconfunction,
        child: Container(
          height: 110,
          width: 100,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF060606),
          ),
          child: icondata,
        ),
      ),
    );
  }
}
