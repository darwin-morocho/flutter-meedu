import 'dart:collection';

typedef ListenerCallback<NotifierType> = void Function(NotifierType);


/// this class define the basic Listener for each SimpleController's subscriber or StateController's subscriber
class ListenerEntry<NotifierType>
    extends LinkedListEntry<ListenerEntry<NotifierType>> {
  final ListenerCallback<NotifierType> listener;
  ListenerEntry(this.listener);
}
