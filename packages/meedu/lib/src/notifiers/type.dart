import 'dart:collection';

typedef ListenerCallback<T> = void Function(T);

/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
class ListenerEntry<T> extends LinkedListEntry<ListenerEntry<T>> {
  final ListenerCallback<T> listener;
  ListenerEntry(this.listener);
}
