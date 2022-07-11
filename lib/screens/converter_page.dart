import 'package:calculator/constants.dart';
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
          UnitDropdown(widget.unit[0], widget.unit),
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
          UnitDropdown(widget.unit[1], widget.unit),
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
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '8',
                  kWhiteColorText,
                  () {
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '9',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '5',
                  kWhiteColorText,
                  () {
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '6',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '2',
                  kWhiteColorText,
                  () {
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '3',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RoundButton(
                  '00',
                  kWhiteColorText,
                  () {
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '0',
                  kWhiteColorText,
                  () {
                    setState(() {});
                  },
                  const NeumorphicBoxShape.circle(),
                  8,
                ),
                RoundButton(
                  '.',
                  kWhiteColorText,
                  () {
                    setState(() {});
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
