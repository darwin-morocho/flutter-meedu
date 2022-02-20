// ignore_for_file: avoid_dynamic_calls

import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

typedef _BuildWhen<S> = bool Function(S prev, S current);
typedef _BuildBySelect<T, S> = S Function(T);

/// enum used to identifier filters used in a provider
enum Filter {
  /// .select filter for SimpleProvider and StateProvider
  select,

  /// .when filter fot StateProvider
  /// this filter only can be  used with ref.watch
  when,

  /// .ids filter for SimpleProvider
  /// this filter only can be  used with ref.watch
  ids,
}

/// class to save a Notifier, the listener and the rebuild function
class Target<Notifier, R> extends Provider<Notifier> {
  // ignore: public_member_api_docs
  Target(this.notifier);

  /// a SimpleNotifier or a StateNotifier
  final Notifier notifier;

  /// listener to listen the changes in our Notifiers
  late void Function(dynamic) listener;

  /// function to rebuild the Consumer
  void Function()? rebuild;

  /// used to store the value returned by .select or .when
  late R selectValue;

  /// callback defined when a filter is used
  dynamic callback;

  /// filter type
  late Filter filter;
}

/// extension for SimpleProvider
extension SimpleProviderExt<Notifier> on SimpleProvider<Notifier> {
  /// use this method to rebuild your Consumer when a value has changed
  /// or you can use a boolean condition. Check the documentation for more info.
  Target<Notifier, R> select<R>(_BuildBySelect<Notifier, R> cb) {
    // get the  Notifier attached to this SimpleProvider
    final target = Target<Notifier, R>(read);
    target.filter = Filter.select;
    target.callback = cb;
    return target;
  }

  /// use this method to rebuild your Consumer using ids (a list of strings)
  /// passed when you call [notify(['id1','id2',...])]
  ///
  /// If you pass to notify method using
  /// an empty list of ids you can use [allowNotifyWithEmptyIds]
  /// to decide if the Consumer widget or a ProviderListener must be notified
  @Deprecated('the .ids filter is obsolete in favor to .select'
      ' and it will be removed in flutter_meedu:^6.x.x')
  Target<Notifier, List> ids(
    List<String> Function() cb, {
    bool allowNotifyWithEmptyIds = true,
  }) {
    final target = Target<Notifier, List>(read);
    target.filter = Filter.ids;
    // ignore: prefer_function_declarations_over_variables
    final listener = (_) {
      final List<String> listeners = _;
      // get the ids passed in the notify method
      // get the ids returned in the callback
      final ids = cb();
      if (listeners.isNotEmpty) {
        // if the current Consumer contains at least one id inside the listeners
        for (final id in ids) {
          if (listeners.contains(id)) {
            if (target.rebuild != null) {
              target.rebuild!();
            }
            break;
          }
        }
      } else if (allowNotifyWithEmptyIds) {
        // update the widget if listeners is empty
        if (target.rebuild != null) {
          target.rebuild!();
        }
      }
    };
    target.listener = listener as dynamic;
    return target;
  }
}

/// extension for StateProvider
extension StateProviderExt<Notifier extends StateNotifier<S>, S>
    on StateProvider<Notifier, S> {
  /// use this method to rebuild your Consumer using the previous state and the current
  /// state to return a boolean
  Target<Notifier, bool> when(_BuildWhen<S> cb) {
    final target = Target<Notifier, bool>(read);
    target.filter = Filter.when;
    target.callback = cb;
    return target;
  }

  /// use this method to rebuild your Consumer when a value in the state has changed
  /// or you can use a boolean condition. Check the documentation for more info.
  Target<Notifier, R> select<R>(_BuildBySelect<S, R> cb) {
    final target = Target<Notifier, R>(read);
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
  // ignore: prefer_function_declarations_over_variables
  final listener = (_) {
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

  // ignore: prefer_function_declarations_over_variables
  final listener = (newState) {
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
  final notifier = target.notifier as StateNotifier;
  target.selectValue = cb(notifier.state, notifier.state);

  // ignore: prefer_function_declarations_over_variables
  final listener = (newState) {
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
