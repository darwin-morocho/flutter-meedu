import 'dart:io';

import 'package:yaml/yaml.dart';

import 'base_path.dart';

File get pubspecFile => File('${basePath}pubspec.yaml');

Map<String, dynamic> get pubspec {
  final doc = loadYaml(pubspecFile.readAsStringSync());
  return Map<String, dynamic>.from(doc);
}
