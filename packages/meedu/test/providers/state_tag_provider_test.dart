import 'package:meedu/provider.dart';
import 'package:test/test.dart';

import '../state/state_controller_test.dart';

void main() {
  setUp(() {
    _stateTagProvider.clear();
  });
  test('StateTagProvider', () {
    expect(_stateTagProvider.count, 0);
    final provider1 = _stateTagProvider.find('1');
    final provider2 = _stateTagProvider.find('2');
    expect(_stateTagProvider.count, 2);
    provider1.read.onEmailChanged('test@test.com');

    expect(_stateTagProvider.find('1').read.state.email, 'test@test.com');
    expect(provider2.read.state.email, '');

    provider1.dispose();
    expect(_stateTagProvider.count, 1);
    provider2.dispose();
    expect(_stateTagProvider.count, 0);
  });
}

final _stateTagProvider = StateProvider.withTag(
  (ref) => LoginController(),
);
