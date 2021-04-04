part of 'base_provider.dart';

class SimpleProvider<T extends SimpleNotifier> extends BaseProvider<T> {
  SimpleProvider(_LazyCallback<T> create, [bool _autoDispose = false])
      : super(
          create,
          _autoDispose,
        );

  static SimpleProvider<T> autoDispose<T extends SimpleNotifier>(_LazyCallback<T> create) {
    return SimpleProvider(create, true);
  }
}
