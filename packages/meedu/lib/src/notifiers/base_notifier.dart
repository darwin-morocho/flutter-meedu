import 'dart:async';
import 'dart:collection';
import 'package:meedu/provider.dart';
import 'package:meta/meta.dart' show mustCallSuper;

typedef ListenerCallback<T> = void Function(T);

/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
class _ListenerEntry<T> extends LinkedListEntry<_ListenerEntry<T>> {
  final ListenerCallback<T> listener;
  final bool autoDispose;
  _ListenerEntry(this.listener, this.autoDispose);
}

/// Define a base controller for SimpleController and StateController
abstract class BaseNotifier<T> {
  /// if the Notifier was created using a SimpleProvider or a StateProvider
  int? containerHash;

  /// list to save the subscribers
  LinkedList<_ListenerEntry<T>>? _listeners = LinkedList<_ListenerEntry<T>>();

  /// Tell us if the controller was disposed
  bool get disposed => _listeners == null;

  bool get hasListeners => !disposed ? _listeners!.isNotEmpty : false;

  StreamController<T>? _controller;

  /// A broadcast stream representation of a [StateNotifier].
  Stream<T> get stream {
    _controller ??= StreamController<T>.broadcast();
    return _controller!.stream;
  }

  /// check if the controller is mounted
  void _debugAssertNotDisposed() {
    assert(_listeners != null, 'A $runtimeType was used after being disposed.');
  }

  /// add a new listener
  void addListener(ListenerCallback<T> listener, [autoDispose = false]) {
    _debugAssertNotDisposed();
    _listeners!.add(_ListenerEntry<T>(listener, autoDispose));
  }

  /// remove a listener
  void removeListener(ListenerCallback<T> listener, [bool isExternalBuild = false]) {
    if (_listeners != null) {
      for (final _ListenerEntry<T> entry in _listeners!) {
        if (entry.listener == listener) {
          entry.unlink();
          break;
        }
      }

      // if this notifier was created using autoDispose equals trueand the listener
      // was not removed by a hot reload or  didUpdateWidget
      if (this.containerHash != null && !isExternalBuild) {
        final container = BaseProvider.notifiers[this.containerHash]!;
        if (container.autoDispose) {
          final elements = _listeners!.where((e) => e.autoDispose);
          if (elements.isEmpty) {
            container.reference.dispose();
          }
        }
      }
    }
  }

  /// notify to listeners and rebuild the widgets
  ///
  /// [listeners] a list of strings to update the widgets (MeeduBuilder) with the ids inside the list
  void notify(T data) {
    _debugAssertNotDisposed();

    if (_listeners!.isNotEmpty) {
      for (final _ListenerEntry<T> entry in _listeners!) {
        if (entry.list != null) entry.listener(data);
      }
    }
  }

  /// Called when this object is inserted into the tree using a [MeeduBuilder].
  void onInit();

  /// when the MeeduBuilder was mounted
  void onAfterFirstLayout();

  /// use to listen when the controller was deleted from memory
  @mustCallSuper
  void onDispose() async {
    _debugAssertNotDisposed();
    _listeners!.clear();
    _listeners = null;
  }
}
