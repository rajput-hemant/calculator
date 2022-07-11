import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';

class UnitDropdown extends StatefulWidget {
  final String firstValue;
  final List<String> unit;
  const UnitDropdown(this.firstValue,this.unit);
  @override
  State<UnitDropdown> createState() => _UnitDropdownState();
}

class _UnitDropdownState extends State<UnitDropdown> {
  int initout = 0;
  int targetout = 0;
  late String setValue = widget.firstValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        const Spacer(
          flex: 10,
        ),
        SelectableText(
          '$initout',
          style: kConverterStyle,
          showCursor: true,
        ),
        const Spacer(
          flex: 80,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: DropdownButton(
            dropdownColor: const Color(0xFF060606),
            value: setValue,
            onChanged: (String? selected) {
              setState(() {
                setValue = selected!;
              });
            },
            items: widget.unit.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const Spacer(
          flex: 10,
        )
      ],
    );
  }
}
