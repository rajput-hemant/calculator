import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widgets/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'About';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              height: 120,
            ),
            const SizedBox(
              height: 12,
            ),
            const ListTile(
              title: Center(
                child: Text(
                  'Calculator',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Center(
                child: Text('v0.1.0'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "A Simple but elegant Calculator app made with Flutter using\n"
                "Google's Material Design with\n"
                "Currency (Exchange Rate)\n"
                "and Unit Converter.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PTSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'This is an Open-Source project and can be found on',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(140, 50),
                padding: const EdgeInsets.all(10),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/GitHub_logo_2013.svg/600px-GitHub_logo_2013.svg.png',
                // color: Colors.white,
                height: 25,
              ),
              onPressed: () =>
                  UrlLauncher('https://github.com/rajput-hemant/calculator'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'If you liked our work\n'
                'show some ❤️ and ⭐ the Repository.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                fixedSize: const Size(140, 50),
                padding: const EdgeInsets.all(10),
                shadowColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Our Team',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onPressed: () => Alert(
                context: context,
                title: "Contact Us",
                style: const AlertStyle(
                  isCloseButton: false,
                  backgroundColor: Color(0xFF171717),
                  titleStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Column(
                  children: [
                    teamTile(
                        'Khushal Agarwal', 'https://github.com/Khushal-ag'),
                    teamTile(
                        'Hemant Rajput', 'https://github.com/rajput-hemant'),
                    teamTile('Ritik Kuntal', 'https://github.com/b49-Ritik'),
                    teamTile('Vikas Singh', 'https://github.com/B-63Vikas'),
                    teamTile(
                        'Ayush Sharma', 'https://github.com/AyushSharma3566'),
                    teamTile(
                        'Suhani Pachouri', 'https://github.com/Suhanipachouri'),
                    teamTile(
                        'Sakshi Chaudhary', 'https://github.com/Sakshi-Chy27'),
                    teamTile('Kuhoo Saxena', 'https://github.com/SaxenaKuhoo'),
                    teamTile('Shruti', 'https://github.com/shru-ty'),
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ).show(),
            ),
            const Spacer(flex: 2),
            const Text(
              "Made with ❤️ using Flutter.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            )
          ],
        ),
      ),
    );
  }

  ListTile teamTile(String name, String url) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'Montserrat',
        ),
      ),
      trailing: IconButton(
        onPressed: () => UrlLauncher(url),
        icon: const Icon(FontAwesomeIcons.github),
      ),
    );
  }
}
