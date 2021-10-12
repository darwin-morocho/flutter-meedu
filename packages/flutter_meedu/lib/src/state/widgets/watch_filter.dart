import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

typedef BuildWhen<S> = bool Function(S prev, S current);
typedef BuildBySelect<T, S> = S Function(T);

enum Filter { select, when, ids }

/// class to save a Notifier, the listener and the rebuild function
class Target<Notifier, R> extends Provider<Notifier> {
  /// a SimpleNotifier or a StateNotifier
  final Notifier notifier;

  /// listaner to listen the changes in our Notifiers
  late Function(dynamic) listener;

  /// function to rebuild the Consumer
  void Function()? rebuild;

  /// used to store the value returned by .select or .when
  late R selectValue;

  dynamic callback;

  late Filter filter;

  Target(this.notifier);
}

/// extension for SimpleProvider
extension SimpleProviderExt<Notifier> on SimpleProvider<Notifier> {
  /// use this method to rebuild your [Consumer] when a value has changed
  /// or you can use a boolean condition. Check the documentation for more info.
  Target<Notifier, R> select<R>(BuildBySelect<Notifier, R> cb) {
    // get the  Notifier attached to this SimpleProvider
    final notifier = this.read;

    final target = Target<Notifier, R>(notifier);
    target.filter = Filter.select;
    target.callback = cb;
    return target;
  }

  /// use this method to rebuild your [Consumer] using ids (a list of strings)
  /// passed when you call [notify(['id1','id2',...])]
  Target<Notifier, List> ids(List<String> Function() cb) {
    final target = Target<Notifier, List>(this.read);
    target.filter = Filter.ids;
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
  Target<Notifier, bool> when(BuildWhen<S> cb) {
    final notifier = this.read;
    final target = Target<Notifier, bool>(notifier);
    target.filter = Filter.when;
    target.callback = cb;
    return target;
  }

  /// use this method to rebuild your [Consumer] when a value in the state has changed
  /// or you can use a boolean condition. Check the documentation for more info.
  Target<Notifier, R> select<R>(BuildBySelect<S, R> cb) {
    final notifier = this.read;
    final target = Target<Notifier, R>(notifier);
    target.filter = Filter.select;
    target.callback = cb;
    return target;
  }
}

/// create the listener for provider.select filter (SimpleProvider)
void createSimpleSelectListener(Target target) {
  final cb = target.callback;
  final notifier = target.notifier;
  // get an initial value using the callback
  dynamic prevValue = cb(notifier);
  target.selectValue = prevValue;

  // listener with  the logic to rebuild the Consumer
  final listener = (dynamic _) {
    final value = cb(notifier);
    target.selectValue = value;
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
}

/// create the listener for provider.select filter (StateProvider)
void createStateSelectListener(Target target) {
  // get an initial value using the callback
  final cb = target.callback;
  dynamic prevValue = cb(target.notifier.state);
  target.selectValue = prevValue;

  final Function(dynamic) listener = (dynamic newState) {
    final value = cb(target.notifier.state);
    target.selectValue = value;
    // check if the value has changed
    if (prevValue != value || (value is bool && value)) {
      if (target.rebuild != null) {
        target.rebuild!();
      }
    }
    prevValue = value;
  };
  target.listener = listener;
}

/// create the listener for provider.when filter
void createWhenListener(Target target) {
  final cb = target.callback;
  final notifier = target.notifier;
  target.selectValue = cb(notifier.state, notifier.state);

  final Function(dynamic) listener = (dynamic newState) {
    // rebuild the Consumer using the boolean returned by the callback
    final allowRebuild = cb(notifier.oldState, newState);
    target.selectValue = allowRebuild;
    if (allowRebuild) {
      if (target.rebuild != null) {
        target.rebuild!();
      }
    }
  };
  target.listener = listener;
}
