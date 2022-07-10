import 'package:calculator/brain/calculator_brain.dart';
import 'package:calculator/constants.dart';
import 'package:calculator/widgets.dart/roundButton.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets.dart/utilityButton.dart';

class calculator_ui extends StatefulWidget {
  @override
  State<calculator_ui> createState() => _calculator_uiState();
}

class _calculator_uiState extends State<calculator_ui> {
  String result = '0';
  var menu = ['About', 'Settings'];
  var appBarHeight = AppBar().preferredSize.height;

  CalculatorBrain calc = CalculatorBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'unit_converter');
              },
              icon: const Icon(
                FontAwesomeIcons.boxesStacked,
                size: 20,
              )),
          PopupMenuButton(
            onSelected: (String? newitem) {
              print(newitem);
            },
            itemBuilder: (BuildContext) {
              return menu.map((String mychoice) {
                return PopupMenuItem(
                  value: mychoice,
                  child: Text(
                    mychoice,
                    style: const TextStyle(
                      fontFamily: 'PTSans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                );
              }).toList();
            },
            elevation: 30,
            color: kButtonColor,
            offset: Offset(0.0, appBarHeight),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 70,
                    ),
                    child: Text(
                      result,
                      style: kResultTextStyle,
                      softWrap: false,
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
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                child: Divider(
                  color: kButtonColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RoundButton(
                      'AC',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('AC');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '⌫',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('⌫');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '+/-',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('+/-');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    utilityButton(
                      '÷',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('÷');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      12,
                      kButtonColor,
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
                      '7',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('7');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '8',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('8');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '9',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('9');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    utilityButton(
                      'x',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('x');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      12,
                      kButtonColor,
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
                      '4',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('4');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '5',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('5');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '6',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('6');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    utilityButton(
                      '—',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('-');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      12,
                      kButtonColor,
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
                      '1',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('1');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '2',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('2');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '3',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('3');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    utilityButton(
                      '+',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('+');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      12,
                      kButtonColor,
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
                      '%',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('%');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '0',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('0');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    RoundButton(
                      '.',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('.');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      8,
                    ),
                    utilityButton(
                      '=',
                      kWhiteColorText,
                      () {
                        setState(() {
                          result = calc.buttonPressed('=');
                        });
                      },
                      const NeumorphicBoxShape.circle(),
                      12,
                      kEqualColor,
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
      ),
    );
  }
}
