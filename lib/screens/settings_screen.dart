import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'Settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            'Version',
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text('0.1.0'),
        ),
      ),
    );
  }
}
