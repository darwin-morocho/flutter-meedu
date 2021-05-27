part of 'consumer_widget.dart';

void Function(dynamic) createSimpleProviderListener<T, S>({
  required SimpleProvider<T> provider,
  required void Function() rebuild,
  required List<String>? buildByIds,
  required BuildBySelect<T, S>? buildBySelect,
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
    } else if (buildByIds != null && listeners.isNotEmpty) {
      // if the update method was called with ids
      //  if the current MeeduBuilder id is inside the listeners
      final ids = buildByIds;
      for (final String id in ids) {
        if (listeners.contains(id)) {
          rebuild();
          break;
        }
      }
    } else {
      // update the widget if  listeners is empty
      rebuild();
    }
  };
  (notifier as SimpleNotifier).addListener(listener);
  return listener;
}

void Function(dynamic) createStateProviderListener<S>({
  required StateProvider<StateNotifier<S>, S> provider,
  required void Function() rebuild,
  required BuildWhen<S>? buildWhen,
}) {
  final notifier = provider.read;

  final listener = (dynamic newState) {
    // if the buildWhen param is defined
    if (buildWhen != null) {
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
