import 'package:args/command_runner.dart';
import 'package:meedu_cli/src/initialize/initialize.dart';

class Commands extends CommandRunner<void> {
  Commands()
      : super(
          'meedu',
          '',
        ) {
    addCommand(InitializeCommand(true));
  }
}
