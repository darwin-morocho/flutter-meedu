part of 'consumer_widget.dart';

typedef BuildWhen<S> = bool Function(S prev, S current);
typedef BuildBySelect<T, S> = S Function(T);

/// class to save a Provider, the listener and the rebuild function
class _Target<Notifier, S> extends Provider<Notifier> {
  final BaseProvider<Notifier> provider;
  late Function(dynamic) listener;
  void Function()? rebuild;

  _Target({
    required this.provider,
  });
}

/// extension for SimpleProvider
extension SimpleProviderExt<Notifier> on SimpleProvider<Notifier> {
  _Target<Notifier, List> select(BuildBySelect<Notifier, Object?> cb) {
    final notifier = this.read;
    Object? prevValue = cb(notifier);
    final target = _Target<Notifier, List>(provider: this);
    final listener = (dynamic _) {
      final value = cb(notifier);
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

  _Target<Notifier, List> ids(List<String> Function() cb) {
    final target = _Target<Notifier, List>(provider: this);
    final listener = (dynamic _) {
      final listeners = _ as List<String>;
      final ids = cb();
      if (listeners.isNotEmpty) {
        // if the update method was called with ids
        //  if the current MeeduBuilder id is inside the listeners
        for (final String id in ids) {
          if (listeners.contains(id)) {
            if (target.rebuild != null) {
              target.rebuild!();
            }
            break;
          }
        }
      } else if (listeners.isEmpty) {
        // update the widget if  listeners is empty
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
  _Target<Notifier, S> when(BuildWhen<S> cb) {
    final notifier = this.read;
    final target = _Target<Notifier, S>(provider: this);

    final Function(dynamic) listener = (dynamic newState) {
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

  _Target<Notifier, S> select(BuildBySelect<S, Object?> cb) {
    final notifier = this.read;
    Object? prevValue = cb(notifier.state);
    final target = _Target<Notifier, S>(provider: this);
    final Function(dynamic) listener = (dynamic newState) {
      final value = cb(notifier.state);
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
