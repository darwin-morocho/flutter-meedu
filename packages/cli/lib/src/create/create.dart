import 'package:args/command_runner.dart';

class CreateCommand extends Command {
  @override
  String get description =>
      'creates a new flutter project using flutter_meedu as a default state management';

  @override
  String get name => 'create';

  @override
  List<String> get aliases => ['-c'];

  @override
  Future<void> run() async {
    
  }
}
