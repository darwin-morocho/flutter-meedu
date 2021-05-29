import 'package:meedu/meedu.dart';
import 'package:meta/meta.dart' show sealed, visibleForTesting;
import '../notifiers/base_notifier.dart';
import '../notifiers/state_notifier.dart';
import 'provider_scope.dart';
import 'provider_container.dart';

part 'simple/simple_tag_provider.dart';
part 'simple/simple_provider.dart';
part 'state/state_tag_provider.dart';
part 'state/state_provider.dart';
part 'provider_reference.dart';

/// defines the creator function structure
typedef _LazyCallback<T> = T Function(ProviderReference ref);

@sealed
abstract class BaseProvider<T> {
  /// save the current route name in flutter apps
  static String? creatorName;

  /// callback to create one Instance of [T] when it was need it
  _LazyCallback<T> _creator;

  /// callback to override the main creator callback
  _LazyCallback<T>? _overriddenCreator;

  /// reference to save arguments and a disposable callback for each notifier
  ProviderReference? _ref;

  /// tell us if the SimpleNotifier or StateNotifier was created
  bool _mounted = false;
  bool get mounted => _mounted;

  /// used to check if the notifier must be disposed when the route who creates this notifier is popped
  final bool _autoDispose;

  /// callback to be called when the notifier is disposed
  void Function()? _onDisposed;

  BaseProvider(
    this._creator, {
    bool autoDispose = false,
    void Function()? onDisposed,
  })  : _autoDispose = autoDispose && creatorName != null,
        _onDisposed = onDisposed;

  // Custom implementation of hash code optimized for reading providers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;

  /// set the arguments to be available in the ProviderReference
  void setArguments(dynamic arguments) {
    if (_ref == null) {
      _ref = ProviderReference(
        arguments: arguments,
        providerDisposeCallback: _dispose,
      );
    }
  }

  /// returs always the same instance of [T], if it is not created yet this will create it.
  T get read {
    // if the notifier was created before
    if (_mounted) {
      return ProviderScope.containers[this.hashCode]!.notifier as T;
    }

    // check if we have a previous reference
    _ref ??= ProviderReference(providerDisposeCallback: _dispose);

    // create a new Notifier
    final notifier = _overriddenCreator != null ? _overriddenCreator!(_ref!) : _creator(_ref!);

    // save the notifier into containers
    ProviderScope.containers[this.hashCode] = ProviderContainer(
      providerHashCode: this.hashCode,
      notifier: notifier as BaseNotifier,
      reference: _ref!,
      autoDispose: this._autoDispose,
      routeName: BaseProvider.creatorName,
    );
    _mounted = true;
    return notifier;
  }

  /// remove the current Notifier from containers and delete a previous reference
  void _dispose() {
    final container = ProviderScope.containers[this.hashCode];
    if (container != null) {
      container.notifier.onDispose();
      if (_overriddenCreator != null) {
        _overriddenCreator = null;
      }
      _ref = null;
      _mounted = false;
      if (_onDisposed != null) {
        _onDisposed!();
      }
    }
  }

  /// dispose the notifier linked to this provider
  ///
  /// Only call this if autoDispose is disabled
  void dispose({bool avoidOnDisposeCallback = false}) {
    assert(_mounted, 'this provider does not have a notifier linked yet');
    if (avoidOnDisposeCallback) {
      _onDisposed = null;
    }
    _ref!.dispose();
    ProviderScope.containers.remove(this.hashCode);
  }

  /// overrides the creator function of this provider useful for unit test.
  ///
  /// [WARNING] if [force] is true the new creator callback becomes in the main creator
  void overrideProvider(
    _LazyCallback<T> creator, {
    bool force = false,
  }) {
    if (mounted) {
      dispose();
    }
    if (force) {
      _creator = creator;
    } else {
      _overriddenCreator = creator;
    }
  }
}
