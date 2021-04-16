import 'package:meta/meta.dart' show sealed;
import '../notifiers/base_notifier.dart';
import '../notifiers/state_notifier.dart';

part 'simple_provider.dart';
part 'state_provider.dart';
part 'provider_container.dart';
part 'provider_reference.dart';

typedef _LazyCallback<T> = T Function(ProviderReference ref);

@sealed
abstract class BaseProvider<T> {
  /// save the current route name in flutter apps
  static String? flutterCurrentRoute;

  /// save the notifiers in one instance of PtoviderContainer
  static final containers = <int, ProviderContainer>{};

  /// callback to create one Instance of [T] when it was need it
  _LazyCallback<T> _create;

  /// reference to save arguments and a disposable callback for each notifier
  ProviderReference? _ref;

  /// tell us if the SimpleNotifier or StateNotifier was created
  bool _mounted = false;
  bool get mounted => _mounted;

  final bool _autoDispose;
  BaseProvider(this._create, [this._autoDispose = false]);

  /// set the arguments to be available in the ProviderReference
  T setArguments(Object arguments) {
    if (_ref == null) {
      _ref = ProviderReference(arguments: arguments, providerDisposeCallback: _dispose);
    }
    return this.read;
  }

  /// returs always the same instance of [T], if it is not created yet this will create it.
  T get read {
    // if the notifier was created before
    if (_mounted) {
      return containers[this.hashCode]!.notifier as T;
    }

    // check if we have a previous reference
    _ref = _ref ??
        ProviderReference(
          providerDisposeCallback: _dispose,
        );

    // create a new Notifier
    final notifier = _create(_ref!);

    // save the notifier into containers
    BaseProvider.containers[this.hashCode] = ProviderContainer(
      providerHashCode: this.hashCode,
      notifier: notifier as BaseNotifier,
      reference: _ref!,
      autoDispose: this._autoDispose,
      routeName: BaseProvider.flutterCurrentRoute,
    );
    _mounted = true;
    return notifier;
  }

  /// remove the current Notifier from containers and delete a previous reference
  void _dispose() {
    final container = BaseProvider.containers[this.hashCode];
    if (container != null) {
      container.notifier.onDispose();
    }
    _ref = null;
    _mounted = false;
  }

  /// dispose the notifier linked to this provider
  ///
  /// Only call this if autoDispose is disabled
  void dispose() {
    assert(_mounted, 'this provider does not have a notifier linked yet');
    _ref!.dispose();
    BaseProvider.containers.remove(this.hashCode);
  }

  // Custom implementation of hash code optimized for reading providers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}
