import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../brain/calculator_brain.dart';
import 'unit_converter_screen.dart';
import '../utils/constants.dart';
import '../widgets/round_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = '0';
  var menu = ['About', 'Settings'];
  var appBarHeight = AppBar().preferredSize.height;

  CalculatorBrain calc = CalculatorBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
          child: Image.asset('assets/images/app_icon.png'),
        ),
        title: const Text(
          "Calculator",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, UnitConverterScreen.routeName),
            icon: const Icon(
              FontAwesomeIcons.boxesStacked,
              size: 20,
            ),
          ),
          PopupMenuButton(
            color: const Color(0xFF171717),
            onSelected: (String? newitem) =>
                Navigator.pushNamed(context, newitem!),
            itemBuilder: (context) {
              return menu.map((String mychoice) {
                return PopupMenuItem(
                  value: mychoice,
                  child: Text(mychoice),
                );
              }).toList();
            },
            elevation: 30,
            offset: Offset(0.0, appBarHeight),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Text(
                    result,
                    style: kResultTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  calc.resultOperationText,
                  style: kOperationTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Divider(color: kButtonColor),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundButton(
                    buttonText: 'C',
                    textWidth: 30,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('AC')),
                    backgroundColor: Colors.red.shade500,
                    colorText: Colors.black,
                  ),
                  RoundButton(
                    buttonText: '⌫',
                    textWidth: 26,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('⌫')),
                    colorText: Colors.red.shade500,
                  ),
                  RoundButton(
                    buttonText: '±',
                    textWidth: 30,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('+/-')),
                    colorText: Colors.blue,
                  ),
                  RoundButton(
                    buttonText: '÷',
                    textWidth: 35,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('÷')),
                    colorText: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundButton(
                    buttonText: '7',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('7')),
                  ),
                  RoundButton(
                    buttonText: '8',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('8')),
                  ),
                  RoundButton(
                    buttonText: '9',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('9')),
                  ),
                  RoundButton(
                    buttonText: 'x',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('x')),
                    colorText: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundButton(
                    buttonText: '4',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('4')),
                  ),
                  RoundButton(
                    buttonText: '5',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('5')),
                  ),
                  RoundButton(
                    buttonText: '6',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('6')),
                  ),
                  RoundButton(
                    buttonText: '−',
                    textWidth: 30,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('-')),
                    colorText: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundButton(
                    buttonText: '1',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('1')),
                  ),
                  RoundButton(
                    buttonText: '2',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('2')),
                  ),
                  RoundButton(
                    buttonText: '3',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('3')),
                  ),
                  RoundButton(
                    buttonText: '+',
                    textWidth: 30,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('+')),
                    colorText: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundButton(
                    buttonText: '%',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('%')),
                  ),
                  RoundButton(
                    buttonText: '0',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('0')),
                  ),
                  RoundButton(
                    buttonText: '.',
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('.')),
                  ),
                  RoundButton(
                    buttonText: '=',
                    textWidth: 35,
                    onPressed: () =>
                        setState(() => result = calc.buttonPressed('=')),
                    backgroundColor: Colors.blue,
                    colorText: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
