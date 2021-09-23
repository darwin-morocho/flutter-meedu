
import 'package:meedu_cli/src/utils/pubspec.dart';

void validateFlutterProject() {
  /// check if pubspec.yaml exists
  if (!pubspecFile.existsSync()) {
    throw Exception(
      '❌  pubspec.yaml not found! Make sure you are in the root directory of your app',
    );
  }

  if (pubspec["dependencies"] == null) {
    throw Exception(
      '❌  dependencies bloc not found in your pubspec.yaml',
    );
  }

  if (pubspec["dev_dependencies"] == null) {
    throw Exception(
      '❌  dev_dependencies bloc not found in your pubspec.yaml',
    );
  }

  final flutter = pubspec['dependencies']["flutter"];
  if (flutter == null) {
    throw Exception(
      '❌  no flutter project detected',
    );
  }
}
