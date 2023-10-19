import 'package:meta/meta.dart';

import '../notifiers/state_notifier.dart';
import 'base_provider.dart';
import 'providers_container.dart';
import 'state_notifier_provider.dart';

class Provider<E> extends BaseProvider<E, dynamic> {
  Provider(super.callback);

  /// creates a TagProvider
  static TagProvider<E> tag<E>(
    CreatorCallback<E, dynamic> callback,
  ) {
    return TagProvider<E>(callback);
  }

  /// creates an TagArgumentsProvider
  static TagArgumentsProvider<E, A> argumentsTag<E, A>(
    CreatorCallback<E, A> callback,
  ) {
    return TagArgumentsProvider<E, A>(callback);
  }

  /// creates an ArgumentsProvider
  static ArgumentsProvider<E, A> arguments<E, A>(
    CreatorCallback<E, A> callback,
  ) {
    return ArgumentsProvider<E, A>(callback);
  }

  /// creates a StateNotifierProvider
  static StateNotifierProvider<N, S> state<N extends StateNotifier<S>, S>(
    CreatorCallback<N, dynamic> callback, {
    bool autoDispose = true,
  }) {
    return StateNotifierProvider<N, S>(
      callback,
      autoDispose: true,
    );
  }

  /// creates a StateNotifierTagProvider
  static StateNotifierTagProvider<N, S> stateTag<N extends StateNotifier<S>, S>(
    CreatorCallback<N, dynamic> callback, {
    bool autoDispose = true,
  }) {
    return StateNotifierTagProvider<N, S>(
      callback,
      autoDispose: true,
    );
  }

  /// creates a StateNotifierArgumentsProvider
  static StateNotifierArgumentsProvider<N, S, A>
      stateArguments<N extends StateNotifier<S>, S, A>(
    CreatorCallback<N, A> callback, {
    bool autoDispose = true,
    bool tags = false,
  }) {
    return StateNotifierArgumentsProvider(
      callback,
      autoDispose: autoDispose,
    );
  }

  /// creates a StateNotifierArgumentsProvider
  static StateNotifierTagArgumentsProvider<N, S, A>
      stateArgumentsTag<N extends StateNotifier<S>, S, A>(
    CreatorCallback<N, A> callback, {
    bool autoDispose = true,
    bool tags = false,
  }) {
    return StateNotifierTagArgumentsProvider(
      callback,
      autoDispose: autoDispose,
    );
  }
}

class TagProvider<E> extends Provider<E> implements BaseTagProvider {
  TagProvider(super.callback);
}

class ArgumentsProvider<E, A> extends BaseProvider<E, A> {
  ArgumentsProvider(super.callback);
}

class TagArgumentsProvider<E, A> extends ArgumentsProvider<E, A>
    implements BaseTagProvider {
  TagArgumentsProvider(super.callback);
}

abstract class BaseFactoryProvider<E, A> extends BaseProvider<E, A> {
  BaseFactoryProvider(super.callback);

  @override
  @visibleForTesting
  @protected
  E read({String? tag}) {
    throw AssertionError('read is not allowed for FactoryProviders');
  }

  @override
  @visibleForTesting
  @protected
  bool mounted({String? tag}) {
    throw AssertionError('mounted is not allowed for FactoryProviders');
  }

  @override
  @visibleForTesting
  @protected
  void setArguments(A args, {String? tag}) {
    throw AssertionError('setArguments is not allowed for FactoryProviders');
  }

  @override
  @visibleForTesting
  @protected
  Element<E>? dispose({String? tag}) {
    return super.dispose(tag: tag);
  }
}

class FactoryProvider<E> extends BaseFactoryProvider<E, dynamic> {
  FactoryProvider(super.callback);

  FactoryElement<E> get() {
    final ref = Ref(tag: null);

    return FactoryElement(
      ref: ref,
    )..set(
        creator.callback(ref),
      );
  }

  static FactoryArgumentsProvider<E, A> arguments<E, A>(
    CreatorCallback<E, A> creatorCallback,
  ) {
    return FactoryArgumentsProvider(
      creatorCallback,
    );
  }
}

class FactoryArgumentsProvider<E, A> extends BaseFactoryProvider<E, A> {
  FactoryArgumentsProvider(super.callback);

  FactoryArgumentsElement<E, A> get(A args) {
    final ref = Ref<A>(tag: null)..setArguments(args);

    return FactoryArgumentsElement<E, A>(
      ref: ref,
    )..set(
        creator.callback(ref),
      );
  }
}
