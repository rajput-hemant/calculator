import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:calculator/widgets/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'About';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF141414),
          (Colors.black),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'About us',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Calculator',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Our Calculator is an Flutter application which follows Google\'s Material Design Concept.\n\nIn this application each feature is handcrafted with attention to the smallest details!\n\nMake your day Today tidious Calculations a lot easier and faster with our application.',
                  style: TextStyle(fontSize: 22, fontFamily: 'PTSans'),
                ),
              ),
              SizedBox(
                width: 100,
                child: Divider(
                  color: Colors.grey[850],
                  thickness: 0.2,
                ),
              ),
              TextButton(
                onPressed: () {
                  Alert(
                      context: context,
                      title: 'TEAM',
                      content: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Khushal Agarwal'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/Khushal-ag');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Hemant Rajput'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/rajput-hemant');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Kuhoo Saxena'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/SaxenaKuhoo');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Ritik Kuntal'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/b49-Ritik');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Shruti'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/Khushal-ag');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Suhani Pachouri'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher(
                                    'https://github.com/Suhanipachouri');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Sakshi Chaudhry'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/Sakshi-Chy27');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Vikas Singh'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher('https://github.com/B-63Vikas');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                          ListTile(
                            title: const Text('Ayush Sharma'),
                            trailing: IconButton(
                              onPressed: () {
                                UrlLauncher(
                                    'https://github.com/AyushSharma3566');
                              },
                              icon: const Icon(FontAwesomeIcons.github),
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          color: Colors.blue[700],
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
                child: const ListTile(
                  title: Text(
                    'Our Team',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'PTSans',
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              )
            ],
          )),
    );
  }
}
