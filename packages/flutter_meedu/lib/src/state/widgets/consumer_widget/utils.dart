part of 'consumer_widget.dart';

void Function(dynamic) createSimpleProviderListener<T>({
  required SimpleProvider<T> provider,
  required void Function() rebuild,
}) {
  final notifier = provider.read;
  final selectedCallback = provider.selectCallback;
  final selectedByIdsCallback = provider.selectByIdsCallback;
  Object? prevValue;
  final listener = (dynamic _) {
    final listeners = _ as List<String>;
    if (selectedCallback != null) {
      final value = selectedCallback(notifier);
      if (prevValue != value) {
        rebuild();
      }
      prevValue = value;
    } else if (selectedByIdsCallback != null && listeners.isNotEmpty) {
      // if the update method was called with ids
      //  if the current MeeduBuilder id is inside the listeners
      final ids = selectedByIdsCallback(notifier);
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
  provider.clearSelect();
  provider.clearSelectByIds();
  return listener;
}

void Function(dynamic) createStateProviderListener<S>({
  required StateProvider<StateNotifier<S>, S> provider,
  required void Function() rebuild,
}) {
  final notifier = provider.read;
  final buildWhen = provider.buildWhenCallback;
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
  provider.clearBuildWhen();
  return listener;
}
