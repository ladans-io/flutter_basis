import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchPhoneCall({required String? phone}) async {
    final uri = Uri.parse('tel://${phone.toString()}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phone';
    }
  }

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        webViewConfiguration: const WebViewConfiguration(headers: <String, String>{'my_header_key': 'my_header_value'}),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchEmail({
    required String? email,
    required String? subject,
    required String? body,
  }) async {
    String url = Uri.encodeFull('mailto:$email?subject=${subject!}&body=${body!}');
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint('Could not launch $url');
    }
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
