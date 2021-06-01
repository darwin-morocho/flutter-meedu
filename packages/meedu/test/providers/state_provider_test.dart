import 'dart:async';

import 'package:meedu/src/providers/base_provider.dart';
import 'package:test/test.dart';

import '../state/state_controller_test.dart';

void main() {
  test('state provider', () async {
    var completer = Completer();
    final loginProvider2 = StateProvider<LoginController, LoginState>(
      (_) {
        return LoginController();
      },
      autoDispose: false,
    );
    final loginProvider = StateProvider<LoginController, LoginState>(
      (_) {
        _.onDispose(() {
          completer.complete(true);
        });
        _.read(loginProvider2);
        return LoginController();
      },
      autoDispose: false,
    );
    expect(loginProvider.mounted, false);
    expect(loginProvider2.mounted, false);
    loginProvider.read;
    expect(loginProvider2.mounted, true);
    loginProvider.dispose();
    expect(await completer.future, true);
  });
}
