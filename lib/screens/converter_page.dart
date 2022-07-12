import 'package:calculator/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../widgets/roundButton.dart';
import '../widgets/unit_dropdown.dart';
import '../widgets/utilityButton.dart';

class ConverterPage extends StatefulWidget {
  final List<String> unit = Length;

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  late String setvalue1 = widget.unit[1];
  late String setvalue2 = widget.unit[4];
  String initout = '0';
  String targetout = '0';
  bool inputreversed = false;

  void cmtoin() {
    if (inputreversed) {
      initout = (double.parse(targetout) * 2.54).toString();
      if (initout.length > 7) {
        initout = double.parse(initout).toStringAsFixed(7);
      }
      if (initout.length > 7) initout = initout.substring(0, 7);
    } else {
      targetout = (double.parse(initout) / 2.54).toString().substring(0, 6);
      if (targetout.length > 7) {
        targetout = double.parse(targetout).toStringAsFixed(7);
      }
      if (targetout.length > 7) targetout = targetout.substring(0, 7);
    }
  }

  void numtap(String a) {
    if (inputreversed) {
      if (targetout == '0') {
        targetout = a;
      } else {
        targetout += a;
      }
    } else {
      if (initout == '0') {
        initout = a;
      } else {
        initout += a;
      }
    }
    cmtoin();
    setState(() {});
  }

  void decimaltap() {
    if (inputreversed) {
      if (targetout == '') {
        targetout = '0.';
      } else if (targetout.contains('.')) {
        null;
      } else {
        targetout += '.';
      }
    } else {
      if (initout == '') {
        initout = '0.';
      } else if (initout.contains('.')) {
        null;
      } else {
        initout += '.';
      }
    }
    if (initout == '' || targetout == '') cleartap();
    cmtoin();
    setState(() {});
  }

  void backtap() {
    if (inputreversed) {
      if (targetout == '') {
        null;
      } else {
        targetout = targetout.substring(0, targetout.length - 2);
      }
    } else {
      if (initout == '') {
        null;
      } else {
        initout = initout.substring(0, initout.length - 2);
      }
    }
    cmtoin();
    setState(() {});
  }

  void cleartap() {
    targetout = '0';
    initout = '0';
    cmtoin();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Length',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      backgroundColor: const Color(0xFF171717),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Spacer(
                flex: 10,
              ),
              SelectableText(
                initout,
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
                  value: setvalue1,
                  onChanged: (String? selected) {
                    setState(() {
                      setvalue1 = selected!;
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
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
            indent: 20,
            endIndent: 20,
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Spacer(
                flex: 10,
              ),
              SelectableText(
                targetout,
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
                  value: setvalue2,
                  onChanged: (String? selected) {
                    setState(() {
                      setvalue2 = selected!;
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
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
            indent: 20,
            endIndent: 20,
            height: 10,
          ),
          const SizedBox(
            height: 100,
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
                    numtap('7');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '8',
                  kWhiteColorText,
                  () {
                    numtap('8');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '9',
                  kWhiteColorText,
                  () {
                    numtap('9');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                utilityButton(
                  'C',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
                    numtap('4');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '5',
                  kWhiteColorText,
                  () {
                    numtap('5');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '6',
                  kWhiteColorText,
                  () {
                    numtap('6');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                utilityButton(
                  '⌫',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
                    numtap('1');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '2',
                  kWhiteColorText,
                  () {
                    numtap('2');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '3',
                  kWhiteColorText,
                  () {
                    numtap('3');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                utilityButton(
                  '🗘',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
                  '00',
                  kWhiteColorText,
                  () {
                    numtap('00');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '0',
                  kWhiteColorText,
                  () {
                    numtap('0');
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '.',
                  kWhiteColorText,
                  () {
                    decimaltap();
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '',
                  kWhiteColorText,
                  () {
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  12,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
