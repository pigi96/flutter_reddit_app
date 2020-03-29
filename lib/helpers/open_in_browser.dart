import 'package:url_launcher/url_launcher.dart';

class OpenInBrowser {
  String openUrl(String url) {
    Future<void> _launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );

      } else {
        throw 'Could not launch $url';
      }
    }
    _launchInBrowser(url);
  }
}
