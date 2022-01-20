import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class LauncherHelper {
  LauncherHelper._();
  static Future<bool> openUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        return launch(url, forceSafariVC: false);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> openEmailDraft(String email, {String? subject}) async {
    try {
      if (await canLaunch("mailto:$email")) {
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: email,
          query: {'subject': subject ?? 'New Title Here'}
              .entries
              .map((e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              .join('&'),
        );

        return launch(emailLaunchUri.toString());
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> share(
    String text, {
    String? subject,
  }) {
    return Share.share(text, subject: subject);
  }

  static Future<void> shareFile(List<String> paths,
      {List<String>? mimeTypes, String? subject, String? text}) {
    return Share.shareFiles(paths,
        mimeTypes: mimeTypes, text: text, subject: subject);
  }
}
