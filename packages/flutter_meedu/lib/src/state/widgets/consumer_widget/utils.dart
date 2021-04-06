part of 'consumer_widget.dart';

void Function(dynamic) createSimpleProviderListener({
  required SimpleProvider provider,
  required void Function() rebuild,
}) {
  final notifier = provider.read;
  final listener = (dynamic _) {
    final listeners = _ as List<String>;
    if (listeners.isNotEmpty) {
      // if the update method was called with ids
      //  if the current MeeduBuilder id is inside the listeners
      // if (filter != null) {
      //   for (final String id in filter.ids) {
      //     if (listeners.contains(id)) {
      //       rebuild();
      //       break;
      //     }
      //   }
      // }
    } else {
      // update the widget if  listeners is empty
      rebuild();
    }
  };
  notifier.addListener(listener);
  return listener;
}

void Function(dynamic) createStateProviderListener<S>({
  required StateProvider<StateNotifier<S>, S> provider,
  required void Function() rebuild,
}) {
  final notifier = provider.read;
  final buildWhen = provider.buildWhen;
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
