import 'package:meta/meta.dart';

import 'base_provider.dart';
import 'providers_container.dart';

class Provider<E> extends BaseProvider<E, dynamic> {
  Provider(
    super.callback, {
    super.tags = false,
  });

  static ArgumentsProvider<E, A> withArguments<E, A>(
    CreatorCallback<E, A> callback, {
    bool tags = false,
  }) {
    return ArgumentsProvider<E, A>(callback, tags: tags);
  }
}

class ArgumentsProvider<E, A> extends BaseProvider<E, A> {
  ArgumentsProvider(
    super.callback, {
    super.tags = false,
  });
}

abstract class BaseFactoryProvider<E, A> extends BaseProvider<E, A> {
  BaseFactoryProvider(super.callback) : super(tags: false);

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

  static FactoryArgumentsProvider<E, A> withArguments<E, A>(
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
