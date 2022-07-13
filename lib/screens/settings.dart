import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const routeName = 'Settings';
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Roboto',
            ),
          ),
          backgroundColor: const Color(0xFF060606),
        ),
        backgroundColor: const Color(0xFF060606),
        body: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 22, top: 25),
                  child: const Text(
                    'Version',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 24, top: 5),
              child: const Text(
                '12.0.14',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                margin: const EdgeInsets.only(left: 22, top: 20),
                child: const Text('Help & Feedback',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8, top: 20),
                child: const Icon(Icons.navigate_next, color: Colors.grey),
              )
            ])
          ],
        )));
  }
}
