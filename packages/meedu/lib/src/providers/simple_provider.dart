part of 'base_provider.dart';

typedef _Select<T> = Object? Function(T);
typedef _SelectByIds<T> = List<String> Function(T);

class SimpleProvider<T> extends BaseProvider<T> {
  SimpleProvider(
    _LazyCallback<T> create, {
    bool autoDispose = true,
  }) : super(
          create,
          autoDispose,
        );

  _Select<T>? _selectCallback;
  _SelectByIds<T>? _selectByIdsCallback;
  _Select<T>? get selectCallback => _selectCallback;
  _SelectByIds<T>? get selectByIdsCallback => _selectByIdsCallback;

  SimpleProvider<T> select(_Select<T> cb) {
    _selectCallback = cb;
    return this;
  }

  SimpleProvider<T> selectByIds(_SelectByIds<T> cb) {
    _selectByIdsCallback = cb;
    return this;
  }

  clearSelect() {
    _selectCallback = null;
  }

  clearSelectByIds() {
    _selectByIdsCallback = null;
  }
}
