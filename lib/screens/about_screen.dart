import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../provider/preferences_provider.dart';
import '../widgets/url_launcher.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(prefrencesProvider).darkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold),
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
            const ListTile(
              title: Center(
                child: Text(
                  'Calculator',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Center(
                child: Text('v0.2.1'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "A Simple but elegant Calculator app made with Flutter using Google's Material Design with Currency (Exchange Rate) and Unit Converter.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'PTSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                'This is an Open-Source project \nand can be found on',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Image.asset(
                'assets/images/github-${isDarkMode ? "dark" : "light"}.png',
                height: 25,
              ),
              onPressed: () => UrlLauncher(
                  'https://github.com/Khushal-ag/calculator/tree/khushal'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'If you liked our work\n'
                'show some ❤️ and ⭐ the Repository.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Our Team',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onPressed: () => Alert(
                context: context,
                title: "Contact Us",
                style: const AlertStyle(
                  isCloseButton: false,
                  titleStyle: TextStyle(
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
                    teamTile(
                        'Ritik Kuntal', 'https://github.com/kuntal-hrithik'),
                    teamTile(
                        'Vikas Singh', 'https://github.com/Vikas-Singh-10'),
                    teamTile('Kalyani Agarwal', 'https://github.com/kalyaniag'),
                    teamTile('Shruti Tripathi', 'https://github.com/shru-ty'),
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Theme.of(context).colorScheme.onBackground,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.background,
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
            ),
            const SizedBox(
              height: 10,
            ),
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
        ),
      ),
      trailing: IconButton(
        onPressed: () => UrlLauncher(url),
        icon: const Icon(FontAwesomeIcons.github),
      ),
    );
  }
}
