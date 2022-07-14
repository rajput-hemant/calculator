import 'package:flutter/material.dart';

import 'round_button.dart';

class KeyPad extends StatelessWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final VoidCallback onPressed3;
  final VoidCallback onPressed4;
  final VoidCallback onPressed5;
  final VoidCallback onPressed6;
  final VoidCallback onPressed7;
  final VoidCallback onPressed8;
  final VoidCallback onPressed9;
  final VoidCallback onPressed0;
  final VoidCallback onPressed00;
  final VoidCallback onPressedDot;
  final VoidCallback onPressedClear;
  final VoidCallback onPressedDel;
  final VoidCallback onPressedConvert;

  const KeyPad({
    Key? key,
    required this.onPressed0,
    required this.onPressed00,
    required this.onPressed1,
    required this.onPressed2,
    required this.onPressed3,
    required this.onPressed4,
    required this.onPressed5,
    required this.onPressed6,
    required this.onPressed7,
    required this.onPressed8,
    required this.onPressed9,
    required this.onPressedDot,
    required this.onPressedDel,
    required this.onPressedClear,
    required this.onPressedConvert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.black12,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundButton(buttonText: '7', onPressed: onPressed7),
                RoundButton(buttonText: '8', onPressed: onPressed8),
                RoundButton(buttonText: '9', onPressed: onPressed9),
                RoundButton(
                  buttonText: 'C',
                  textWidth: 30,
                  onPressed: onPressedClear,
                  colorText: Colors.black,
                  backgroundColor: Colors.red[500]!,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundButton(buttonText: '4', onPressed: onPressed4),
                RoundButton(buttonText: '5', onPressed: onPressed5),
                RoundButton(buttonText: '6', onPressed: onPressed6),
                RoundButton(
                  buttonText: '⌫',
                  textWidth: 26,
                  onPressed: onPressedDel,
                  colorText: Colors.red[500]!,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundButton(buttonText: '1', onPressed: onPressed1),
                RoundButton(buttonText: '2', onPressed: onPressed2),
                RoundButton(buttonText: '3', onPressed: onPressed3),
                RoundButton(
                  buttonText: '',
                  onPressed: () {},
                  backgroundColor: Colors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundButton(
                  buttonText: '00',
                  onPressed: onPressed00,
                ),
                RoundButton(buttonText: '0', onPressed: onPressed0),
                RoundButton(buttonText: '.', onPressed: onPressedDot),
                RoundButton(
                  buttonText: '=',
                  textWidth: 40,
                  colorText: Colors.black,
                  backgroundColor: Colors.blue,
                  onPressed: onPressedConvert,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
