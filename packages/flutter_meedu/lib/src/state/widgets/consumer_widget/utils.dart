part of 'consumer_widget.dart';

void Function(dynamic) createSimpleProviderListener({
  required SimpleProvider provider,
  SimpleFilter? filter,
  required void Function() rebuild,
}) {
  final notifier = provider.read;
  final listener = (dynamic _) {
    final listeners = _ as List<String>;
    if (listeners.isNotEmpty) {
      // if the update method was called with ids
      //  if the current MeeduBuilder id is inside the listeners
      if (filter != null) {
        for (final String id in filter.ids) {
          if (listeners.contains(id)) {
            rebuild();
            break;
          }
        }
      }
    } else {
      // update the widget if  listeners is empty
      rebuild();
    }
  };
  notifier.addListener(listener);
  return listener;
}

void Function(Object?) createStateProviderListener({
  required StateProvider provider,
  StateFilter? filter,
  required void Function() rebuild,
}) {
  final notifier = provider.read;
  final listener = (Object? newState) {
    // if the buildWhen param is defined
    if (filter != null) {
      /// check if the condition allows the rebuild
      if (filter.buildWhen(provider.oldState, newState)) {
        rebuild();
      }
    } else {
      rebuild();
    }
    provider.setOldState(newState);
  };
  notifier.addListener(listener);

  return listener;
}
