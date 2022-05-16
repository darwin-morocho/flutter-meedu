import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    ProviderScope.clear();
  });

  test(
    'Provider',
    () {
      final _repo = Provider(
        (ref) {
          final repo = MyRepo();
          ref.onDispose(
            () {},
          );
          return repo;
        },
      );
      expect(_repo.read.counter, 0);
      _repo.read.counter++;
      expect(_repo.read.counter, 1);
      _repo.dispose();
      expect(_repo.read.counter, 0);
    },
  );

  test(
    'TagProvider',
    () {
      final repo1 = _tagRepo.find('1');

      repo1.read.counter++;
      expect(_tagRepo.find('1').read.counter, 1);
    },
  );
}

final _tagRepo = Provider.withTag(
  (_) => MyRepo(),
);

class MyRepo {
  int counter = 0;
}
