part of 'base_provider.dart';

class SimpleProvider<T> extends BaseProvider<T> {
  SimpleProvider(
    _LazyCallback<T> create, {
    bool autoDispose = true,
  }) : super(
          create,
          autoDispose,
        );
}
