import 'base_provider.dart';

class Provider<E> extends BaseProvider<E, dynamic> {
  Provider(super.callback);

  static ArgumentsProvider<E, A> withArguments<E, A>(
    CreatorCallback<E, A> callback,
  ) {
    return ArgumentsProvider<E, A>(callback);
  }
}

class ArgumentsProvider<E, A> extends BaseProvider<E, A> {
  ArgumentsProvider(super.callback);
}
