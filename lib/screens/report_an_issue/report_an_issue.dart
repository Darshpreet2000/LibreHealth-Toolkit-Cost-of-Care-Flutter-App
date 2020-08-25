import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

reportABug() async {
  String version = await getAppInfo();
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'costofcare225@gmail.com',
    query: 'subject=Bug Report&body=App Version $version',
  );
  if (await canLaunch(_emailLaunchUri.toString())) {
    await launch(_emailLaunchUri.toString());
  } else {
    throw Exception('Could not launch');
  }
}

Future getAppInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String version = packageInfo.version;
  return version;
}
