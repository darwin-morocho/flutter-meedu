import 'package:args/command_runner.dart';

import 'src/commands/create/create.dart';
import 'src/commands/initialize/initialize.dart';
import 'src/commands/page/page.dart';


class Commands extends CommandRunner<void> {
  Commands()
      : super(
          'meedu',
          '',
        ) {
    addCommand(InitializeCommand());
    addCommand(CreateCommand());
    addCommand(PageCommand());
  }
}
