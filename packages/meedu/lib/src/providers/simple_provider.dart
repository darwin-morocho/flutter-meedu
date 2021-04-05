part of 'base_provider.dart';

class SimpleProvider<T extends SimpleNotifier> extends BaseProvider<T> {
  SimpleProvider(
    _LazyCallback<T> create, {
    bool autoDispose = true,
  }) : super(
          create,
          autoDispose,
        );
}
