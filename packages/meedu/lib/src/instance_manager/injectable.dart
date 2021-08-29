part of 'instance_manager.dart';

typedef _LazyBuilderCallback<T> = T Function();
typedef _FactoryBuilderCallback<T, A> = T Function(A? arguments);
typedef _RemoveCallback<T> = void Function(T);

/// A dependency will be create immediately
/// when an instance of this class is created
class Singleton<T> extends _Injectable<T> {
  final T dependency;

  Singleton(
    this.dependency, {
    bool autoRemove = false,
    _RemoveCallback<T>? onRemove,
  }) : super(
          autoRemove: autoRemove,
          onRemove: onRemove,
        );
}

/// stores a callback that will be called when the code calls to
/// Get.i.find and then store the value returned by the builder
/// into a singleton
class _Lazy<T> extends _Injectable<T> {
  _LazyBuilderCallback builder;
  _Lazy(
    this.builder, {
    bool autoRemove = false,
    _RemoveCallback<T>? onRemove,
  }) : super(
          autoRemove: autoRemove,
          onRemove: onRemove,
        );
}

/// stores a callback that will be called every time that
/// the code calls to Get.i.factoryFind
class _Factory<T, A> {
  _FactoryBuilderCallback<T, A> builder;
  _Factory(this.builder);
}

/// a parent class for singletons usinf put and lazy put
abstract class _Injectable<T> {
  /// the route name who creates this instance
  final String? creatorName;

  /// set this value to true when you  want to remove
  /// this dependency when the route who creates this dependency
  /// is popped
  final bool autoRemove;

  /// callback to be called when this dependency is removed
  final _RemoveCallback<T>? onRemove;

  _Injectable({
    required this.autoRemove,
    required this.onRemove,
  }) : creatorName = BaseProvider.creatorName;
}
