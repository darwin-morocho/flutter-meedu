// ignore_for_file: invalid_use_of_protected_member

import '../notifiers/state_notifier.dart';
import 'base_provider.dart';
import 'providers_container.dart';

abstract class BaseStateNotifierProvider<N, S> {}

abstract class ListeneableProvider<N extends StateNotifier<S>, S, A>
    extends BaseProvider<N, A> implements BaseStateNotifierProvider<N, S> {
  ListeneableProvider(
    super.callback, {
    super.autoDispose,
    super.tags = false,
  });

  @override
  Element<N>? dispose({String? tag}) {
    final element = super.dispose(tag: tag);

    final notifier = element?.value;
    if (notifier != null) {
      notifier.dispose();
    }
    return element;
  }

  @override
  void onElementValueAssigned(Element<N> element, bool autoDispose) {
    if (autoDispose) {
      element.value?.setDisposableCallback(
        () => dispose(
          tag: element.ref.tag,
        ),
      );
    }
  }
}

class StateNotifierProvider<N extends StateNotifier<S>, S>
    extends ListeneableProvider<N, S, dynamic> {
  StateNotifierProvider(
    super.creator, {
    super.autoDispose,
    super.tags = false,
  });

  static StateNotifierArgumentsProvider<N, S, A>
      withArguments<N extends StateNotifier<S>, S, A>(
    CreatorCallback<N, A> callback, {
    bool autoDispose = true,
    bool tags = false,
  }) {
    return StateNotifierArgumentsProvider(
      callback,
      autoDispose: autoDispose,
      tags: tags,
    );
  }
}

class StateNotifierArgumentsProvider<N extends StateNotifier<S>, S, A>
    extends ListeneableProvider<N, S, A> {
  StateNotifierArgumentsProvider(
    super.creator, {
    super.autoDispose,
    super.tags = false,
  });
}
