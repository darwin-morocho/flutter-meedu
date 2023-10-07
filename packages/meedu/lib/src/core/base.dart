import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';

typedef Creator<E> = E Function(Ref ref);

abstract class BaseProvider<E> {
  BaseProvider(
    this._creator, {
    this.autoDispose = true,
  });

  final Creator<E> _creator;
  final bool autoDispose;
  Ref? _ref;

  /// tell us if the SimpleNotifier or StateNotifier was created
  bool get mounted => _element != null;

  E? _element;

  E get read {
    if (mounted) {
      return _element!;
    }
    _ref ??= Ref();
    _element = _creator(_ref!);

    if (_element is ListeneableNotifier) {
      (_element as ListeneableNotifier)._disposableCallback = () {
        dispose();
      };
    }

    return _element!;
  }

  void setArguments<Arguments>(Arguments arguments) {
    _ref ??= Ref();
    _ref?._setArguments(arguments);
  }

  @mustCallSuper
  void dispose() {
    _ref?._dispose();
    if (_element is BaseNotifier) {
      (_element as BaseNotifier).dispose();
    }
    _ref = null;
    _element = null;
  }
}

class Ref {
  Object? _arguments;
  void Function()? _onDispose;
  Object? get arguments => _arguments;

  void _setArguments(Object? arguments) {
    _arguments = arguments;
  }

  void _dispose() => _onDispose?.call();

  void onDispose(void Function() callback) {
    _onDispose = callback;
  }
}

/// Define a base notifier for SimpleNotifier and StateNotifier
abstract class BaseNotifier<S> {
  /// used to check if a notifier was disposed
  bool _disposed = false;

  /// Tell us if the notifier was disposed
  bool get disposed => _disposed;

  /// Tell us if the notifier is mounted
  bool get mounted => !_disposed;

  @mustCallSuper
  FutureOr<void> dispose() {
    _disposed = true;
  }

  // Custom implementation of hash code optimized for reading notifiers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

class NotifierProvider<N extends Notifier<S>, S> extends BaseProvider<N> {
  NotifierProvider(
    super.creator, {
    super.autoDispose,
  });

  @override
  void dispose() {
    _element?.dispose();
    super.dispose();
  }
}

class Notifier<S> extends BaseNotifier<S> with ListeneableNotifier {
  late S _state, _oldState;
  S get state => _state;
  S get oldState => _oldState;

  Notifier(S initialState) {
    _state = initialState;
    _oldState = _state;
  }

  @protected
  @mustCallSuper
  @override
  FutureOr<void> dispose() {
    super.dispose();
    clearListeners();
  }
}

mixin ListeneableNotifier<T> {
  final _listeners = LinkedList<ListenerEntry<T>>();

  /// StreamController to allow us listen the notify events as a Stream
  StreamController<T>? _controller;

  /// completer to check if we are emiting events before call dispose
  Completer<void>? _isBusy;

  /// returns true when the current notifier has subscribers
  bool get hasListeners => _listeners.isNotEmpty;

  void Function()? _disposableCallback;

  /// A broadcast stream representation of a [StateNotifier].
  Stream<T> get stream {
    _controller ??= StreamController<T>.broadcast();
    return _controller!.stream;
  }

  void _complete() {
    if (_isBusy != null && !_isBusy!.isCompleted) {
      _isBusy!.complete();
    }
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// only SimpleNotifier or StateNotifier are allowed to call this method, DON'T  call to this method since
  /// a sub-type of SimpleNotifier or StateNotifier
  void notifyListeners(T data) {
    _isBusy = Completer();
    if (_controller != null && !_controller!.isClosed) {
      _controller?.sink.add(data);
    }
    if (_listeners.isNotEmpty) {
      for (final entry in _listeners) {
        if (entry.list != null) entry.listener(data);
      }
    }
    _complete();
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener) {
    _listeners.add(
      ListenerEntry(listener),
    );
  }

  /// remove a listener from the notifier
  void removeListener(ListenerCallback<T> listener) {
    if (_listeners.isNotEmpty) {
      for (final entry in _listeners) {
        if (entry.listener == listener) {
          entry.unlink();
          break;
        }
      }
      if (_listeners.isEmpty) {
        _disposableCallback?.call();
      }
    }
  }

  @protected
  Future<void> clearListeners() async {
    // ignore: unawaited_futures
    _controller?.close();
    if (_isBusy != null) {
      await _isBusy!.future;
    }
    _listeners.clear();
    _disposableCallback?.call();
  }
}

typedef ListenerCallback<T> = void Function(T);

/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
final class ListenerEntry<T> extends LinkedListEntry<ListenerEntry<T>> {
  final ListenerCallback<T> listener;
  ListenerEntry(this.listener);
}
