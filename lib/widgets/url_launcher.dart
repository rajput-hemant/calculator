import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  String link;
  UrlLauncher(this.link) {
    _launchUrl();
  }
  Future<void> _launchUrl() async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        webViewConfiguration: const WebViewConfiguration(),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'can\'t launch $url';
    }
  }
}
