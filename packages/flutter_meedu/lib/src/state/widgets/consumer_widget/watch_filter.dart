part of 'consumer_widget.dart';

typedef BuildWhen<S> = bool Function(S prev, S current);
typedef BuildBySelect<T, S> = S Function(T);

/// class to save a Notifier, the listener and the rebuild function
class _Target<Notifier, S> extends Provider<Notifier> {
  /// a SimpleNotifier or a StateNotifier
  final Notifier notifier;

  /// listaner to listen the changes in our Notifiers
  late Function(dynamic) listener;

  /// function to rebuild the Consumer
  void Function()? rebuild;

  _Target(this.notifier);
}

/// extension for SimpleProvider
extension SimpleProviderExt<Notifier> on SimpleProvider<Notifier> {
  /// use this method to rebuild your [Consumer] when a value has changed
  /// or you can use a boolean condition. Check the documentation for more info.
  _Target<Notifier, List> select(BuildBySelect<Notifier, Object?> cb) {
    // get the  Notifier attached to this SimpleProvider
    final notifier = this.read;
    // get an initial value using the callback
    Object? prevValue = cb(notifier);
    final target = _Target<Notifier, List>(notifier);

    // listener with  the logic to rebuild the Consumer
    final listener = (dynamic _) {
      final value = cb(notifier);
      // check if the value has changed
      if (prevValue != value || (value is bool && value)) {
        if (target.rebuild != null) {
          target.rebuild!(); // rebuild the Consumer
        }
      }
      prevValue = value;
    };
    // save the listener to be added to our Notifier later
    target.listener = listener;
    return target;
  }

  /// use this method to rebuild your [Consumer] using ids (a list of strings)
  /// passed when you call [notify(['id1','id2',...])]
  _Target<Notifier, List> ids(List<String> Function() cb) {
    final target = _Target<Notifier, List>(this.read);
    final listener = (dynamic _) {
      // get the ids passed in the notify method
      final listeners = _ as List<String>;
      // get the ids returned in the callback
      final ids = cb();
      if (listeners.isNotEmpty) {
        // if the current Consumer contains at least one id inside the listeners
        for (final String id in ids) {
          if (listeners.contains(id)) {
            if (target.rebuild != null) {
              target.rebuild!();
            }
            break;
          }
        }
      } else {
        // update the widget if listeners is empty
        if (target.rebuild != null) {
          target.rebuild!();
        }
      }
    };
    target.listener = listener;
    return target;
  }
}

/// extension for StateProvider
extension StateProviderExt<Notifier extends StateNotifier<S>, S>
    on StateProvider<Notifier, S> {
  /// use this method to rebuild your [Consumer] using the previous state and the current
  /// state to return a boolean
  _Target<Notifier, S> when(BuildWhen<S> cb) {
    final notifier = this.read;
    final target = _Target<Notifier, S>(notifier);

    final Function(dynamic) listener = (dynamic newState) {
      // rebuild the Consumer using the boolean returned by the callback
      final allowRebuild = cb(notifier.oldState, newState);
      if (allowRebuild) {
        if (target.rebuild != null) {
          target.rebuild!();
        }
      }
    };
    target.listener = listener;
    return target;
  }

  /// use this method to rebuild your [Consumer] when a value in the state has changed
  /// or you can use a boolean condition. Check the documentation for more info.
  _Target<Notifier, S> select(BuildBySelect<S, Object?> cb) {
    final notifier = this.read;
    // get an initial value using the callback
    Object? prevValue = cb(notifier.state);
    final target = _Target<Notifier, S>(notifier);
    final Function(dynamic) listener = (dynamic newState) {
      final value = cb(notifier.state);
      // check if the value has changed
      if (prevValue != value || (value is bool && value)) {
        if (target.rebuild != null) {
          target.rebuild!();
        }
      }
      prevValue = value;
    };
    target.listener = listener;
    return target;
  }
}
