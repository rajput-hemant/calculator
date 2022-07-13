import 'package:flutter/material.dart';

class UnitBox extends StatelessWidget {

  final Widget icondata;
  final VoidCallback iconfunction;

  const UnitBox({Key? key, required this.icondata, required this.iconfunction}) : super(key: key);

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
