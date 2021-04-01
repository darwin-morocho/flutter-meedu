import '../../get.dart';
import '../../state.dart';
import 'state_provider.dart';

typedef _LazyCallback<T extends BaseController> = T Function();

const String meeduProviderTag = 'meedu-provider';

abstract class BaseProvider<T extends BaseController> {
  /// callback to create one Instance of [T] when it was need it
  _LazyCallback<T> _create;
  BaseProvider(this._create);

  T get controller {
    final created = Get.i.has<T>(tag: meeduProviderTag);
    if (created) {
      return Get.i.find<T>(tag: meeduProviderTag);
    }

    final controller = _create();
    Get.i.put<T>(controller, tag: meeduProviderTag);
    if (this is StateProvider) {
      final state = (controller as StateController).state;
      (this as StateProvider).setOldState(state);
    }
    return controller;
  }

  // Custom implementation of hash code optimized for reading providers.
  //
  // The value is designed to fit within the SMI representation. This makes
  // the cached value use less memory (one field and no extra heap objects) and
  // cheap to compare (no indirection).
  //
  // See also:
  //
  //  * https://dart.dev/articles/dart-vm/numeric-computation, which
  //    explains how numbers are represented in Dart.
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, hash_and_equals
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}
