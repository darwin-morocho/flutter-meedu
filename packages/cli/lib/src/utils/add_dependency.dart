import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'pubspec.dart';

Future<bool> addDependency(
  String package, {
  bool isDev = false,
}) async {
  try {
    final languageCode = Platform.localeName.split('_')[0];

    final url = languageCode == 'zh'
        ? 'https://pub.flutter-io.cn/api/packages/$package'
        : 'https://pub.dev/api/packages/$package';

    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final version = jsonDecode(response.body)['latest']['version'] as String;

      final pubAsString = pubspecFile.readAsStringSync();
      final key = "${isDev ? "dev_" : ""}dependencies:";
      final index = pubAsString.indexOf(key);

      final firstPart = pubAsString.substring(0, index + key.length);
      final secondPart = pubAsString.substring(
        index + key.length,
        pubAsString.length,
      );

      final newPubspec = firstPart + "\n  $package: ^$version" + secondPart;

      stderr.writeln("🔥 Added $package: $version");

      pubspecFile.writeAsStringSync(newPubspec);
      return true;
    }
    return false;
  } catch (_, s) {
    stderr.writeln(_);
    stderr.writeln(s);
    return false;
  }
}
