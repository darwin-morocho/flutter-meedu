import 'package:meta/meta.dart' show sealed;
import '../notifiers/base_notifier.dart';
import '../notifiers/simple_notifier.dart';
import '../notifiers/state_notifier.dart';

part 'simple_provider.dart';
part 'state_provider.dart';

typedef _LazyCallback<T extends BaseNotifier> = T Function(ProviderReference ref);

@sealed
abstract class BaseProvider<T extends BaseNotifier> {
  static String? flutterCurrentRoute; // save the current route name in flutter apps
  static final containers = <int, ProviderContainer>{};

  /// callback to create one Instance of [T] when it was need it
  _LazyCallback<T> _create;
  late ProviderReference _ref;

  final bool _autoDispose;
  BaseProvider(this._create, [this._autoDispose = false]);

  T get read {
    if (BaseProvider.containers.containsKey(this.hashCode)) {
      return containers[this.hashCode]!.notifier as T;
    }
    _ref = ProviderReference(hashCode);
    final notifier = _create(_ref);

    if (this is StateProvider) {
      final state = (notifier as StateNotifier).state;
      (this as StateProvider).setOldState(state);
    }
    BaseProvider.containers[this.hashCode] = ProviderContainer(
      notifier: notifier,
      reference: _ref,
      autoDispose: this._autoDispose,
      routeName: BaseProvider.flutterCurrentRoute,
    );
    return notifier;
  }

  // Custom implementation of hash code optimized for reading providers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

class ProviderContainer {
  final BaseNotifier notifier;
  final ProviderReference reference;
  final String? routeName;
  final bool autoDispose;

  ProviderContainer({
    required this.notifier,
    required this.reference,
    required this.autoDispose,
    required this.routeName,
  });
}

class ProviderReference {
  final int _hashCodeProvider;
  ProviderReference(this._hashCodeProvider);

  T read<T extends BaseNotifier>(BaseProvider<T> provider) {
    return provider.read;
  }

  bool disposed = false;

  /// only call dispose after called to onDipose
  /// ```dart
  /// final counterProvider = SimpleProvider.autoDispose<CounterController>(
  ///   (ref) {
  ///     ref.onDispose(() {
  ///       print("counterProvider disposed");
  ///     });
  ///     return CounterController();
  ///   },
  /// );
  /// ```
  void dispose() {
    if (!disposed && _disposableCallback != null) {
      _disposableCallback!();
      disposed = true;
    }
    BaseProvider.containers.remove(this._hashCodeProvider);
  }

  void Function()? _disposableCallback;

  /// called when the provider is destroyed
  void onDispose(void Function() cb) {
    this._disposableCallback = cb;
  }
}
