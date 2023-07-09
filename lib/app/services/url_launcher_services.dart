import 'package:url_launcher/url_launcher.dart';

class UrlLauncherServices {
  openInstagram(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
