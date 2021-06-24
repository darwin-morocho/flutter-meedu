part of 'consumer_widget.dart';

/// this function create a listener for a Consumer widget when the watch function is used to listen
/// the changes in one SimpleNotifier
///
/// [provider] the provider that contains the notifier to watch
/// [rebuild] callback to rebuild the Consumer when it is need it
/// [buildByIds] a list of ids to be used as a condition for rebuilds
/// [buildBySelect] callback to be used as a condition for rebuilds
void Function(dynamic) createSimpleProviderListener<T>({
  required SimpleProvider<T> provider,
  required void Function() rebuild,
  required List<String>? buildByIds,
  required BuildBySelect<T, Object?>? buildBySelect,
}) {
  final notifier = provider.read;

  Object? prevValue = buildBySelect != null ? buildBySelect(notifier) : null;
  final listener = (dynamic _) {
    final listeners = _ as List<String>;
    if (buildBySelect != null) {
      final value = buildBySelect(notifier);
      if (prevValue != value || (value is bool && value)) {
        rebuild();
      }
      prevValue = value;
    } else if (listeners.isNotEmpty && buildByIds != null) {
      // if the update method was called with ids
      //  if the current MeeduBuilder id is inside the listeners
      final ids = buildByIds;
      for (final String id in ids) {
        if (listeners.contains(id)) {
          rebuild();
          break;
        }
      }
    } else if (listeners.isEmpty) {
      // update the widget if  listeners is empty
      rebuild();
    }
  };
  (notifier as SimpleNotifier).addListener(listener);
  return listener;
}

/// this function create a listener for a Consumer widget when the watch function is used to listen
/// the changes in one StateNotifier
///
/// [provider] the provider that contains the notifier to watch
/// [rebuild] callback to rebuild the Consumer when it is need it
/// [buildWhen] callback to be used as a condition for rebuilds
void Function(dynamic) createStateProviderListener<Notifier extends StateNotifier<S>, S>({
  required StateProvider<Notifier, S> provider,
  required void Function() rebuild,
  required BuildWhen<S>? buildWhen,
  required BuildBySelect<S, Object?>? buildBySelect,
}) {
  final notifier = provider.read;
  Object? prevValue = buildBySelect != null ? buildBySelect(notifier.state) : null;
  final listener = (dynamic newState) {
    if (buildBySelect != null) {
      final value = buildBySelect(notifier.state);
      if (prevValue != value || (value is bool && value)) {
        rebuild();
      }
      prevValue = value;
    } else if (buildWhen != null) {
      // if the buildWhen param is defined
      // print(filter.buildWhen);
      /// check if the condition allows the rebuild
      final allowRebuild = buildWhen(notifier.oldState, newState);
      if (allowRebuild) {
        rebuild();
      }
    } else {
      rebuild();
    }
  };
  notifier.addListener(listener);

  return listener;
}
