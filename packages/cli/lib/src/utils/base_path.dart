import 'package:meedu_cli/src/commands/initialize/initialize.dart';

String get basePath {
  if (InitializeCommand.projectName != null) {
    return "${InitializeCommand.projectName}/";
  }
  return "";
}
