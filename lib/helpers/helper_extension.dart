import 'package:url_launcher/url_launcher.dart';

class UtilityHelper {
  static redirectToURL(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}