// ignore_for_file: hash_and_equals

import 'package:meta/meta.dart';

import '../notifiers/base_notifier.dart';
import '../notifiers/state_notifier.dart';
import '../provider_scope.dart';

part 'base_tag_provider.dart';
part 'provider.dart';
part 'state_notifier_provider.dart';

/// defines the creator function structure
typedef Creator<Element, Arguments> = Element Function(Ref<Arguments> ref);

abstract class ListeneableProvider<T> {}

abstract class BaseProvider<Element, Arguments> {
  BaseProvider(
    this._creator, {
    bool autoDispose = true,
    void Function()? onDisposed,
  }) : _autoDispose = autoDispose;

  /// callback to be called when the notifier is disposed
  void Function()? _onDisposed;

  /// callback to create one Instance of [Element] when it was need it
  late final Creator<Element, Arguments> _creator;

  /// callback to override the main creator callback
  Creator<Element, Arguments>? _overriddenCreator;

  /// used to check if the [Element] must be disposed when the [Element] doesn't have listeners
  final bool _autoDispose;

  bool get autoDispose => _overriddenAutoDispose ?? _autoDispose;

  /// boolean to override the main autoDispose
  bool? _overriddenAutoDispose;

  /// reference to save arguments and a disposable callback for each [Element]
  Ref<Arguments>? _ref;

  /// tell us if the [E] was created
  bool get mounted => _element != null;

  Element? _element;

  /// returs always the same instance of [Element], if it is not created yet this will create it.
  Element get read {
    if (mounted) {
      return _element!;
    }
    _ref ??= Ref<Arguments>();
    // create a new Notifier
    _element = _overriddenCreator != null
        ? _overriddenCreator!(_ref!)
        : _creator(_ref!);

    if (_element is ListeneableNotifier && autoDispose) {
      // ignore: invalid_use_of_protected_member
      (_element as ListeneableNotifier).setDisposableCallback(
        () {
          if (mounted) {
            dispose();
          }
        },
      );
    }
    ProviderScope.instance.add(this);

    return _element!;
  }

  void setArguments(Arguments arguments) {
    _ref ??= Ref<Arguments>();
    _ref?._setArguments(arguments);
  }

  @mustCallSuper
  void dispose() {
    if (!mounted) {
      return;
    }
    _ref?._dispose();
    if (_element is BaseNotifier) {
      (_element as BaseNotifier).dispose();
    }
    _ref = null;
    _element = null;
    _overriddenCreator = null;
    _overriddenAutoDispose = null;
    _onDisposed?.call();
  }

  // Custom implementation of hash code optimized for reading providers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;

  /// overrides the creator function of this provider useful for unit test.
  @visibleForTesting
  void overrideProvider(
    Creator<Element, Arguments> creator, {
    bool? autoDispose,
  }) {
    if (mounted) {
      dispose();
    }
    _overriddenCreator = creator;
    _overriddenAutoDispose = autoDispose;
  }
}

class Ref<A> {
  /// store arguments
  A? _arguments;
  A get arguments {
    assert(_arguments != null,
        'arguments is Null, make sure to call to setArguments before');
    return _arguments!;
  }

  void Function()? _onDispose;

  void _setArguments(A arguments) {
    _arguments = arguments;
  }

  void _dispose() => _onDispose?.call();

  /// called when the linked Element to this reference is destroyed.
  /// This is useful to release resources like dispose timers, streams, etc.
  ///
  /// ```dart
  /// final counterProvider = NotifierProvider<CounterNotifier,State>(
  ///   (ref) {
  ///     ref.onDispose(() {
  ///      /// YOUR CODE HERE
  ///     });
  ///     return CounterNotifier();
  ///   },
  /// );
  /// ```
  void onDispose(void Function() callback) {
    _onDispose = callback;
  }
}
