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
  });
}

class StateNotifierArgumentsProvider<N extends StateNotifier<S>, S, A>
    extends ListeneableProvider<N, S, A> {
  StateNotifierArgumentsProvider(
    super.creator, {
    super.autoDispose,
  });
}

class StateNotifierTagProvider<N extends StateNotifier<S>, S>
    extends StateNotifierProvider<N, S> implements BaseTagProvider {
  StateNotifierTagProvider(
    super.creator, {
    super.autoDispose,
  });
}

class StateNotifierTagArgumentsProvider<N extends StateNotifier<S>, S, A>
    extends StateNotifierArgumentsProvider<N, S, A> implements BaseTagProvider {
  StateNotifierTagArgumentsProvider(
    super.creator, {
    super.autoDispose,
  });
}
