part of 'base_provider.dart';

class ProviderReference {
  final Object? arguments;
  final void Function() _providerDisposeCallback;
  ProviderReference({
    this.arguments,
    required void Function() providerDisposeCallback,
  }) : _providerDisposeCallback = providerDisposeCallback;

  T read<T extends BaseNotifier>(BaseProvider<T> provider) {
    return provider.read;
  }

  bool disposed = false;

  /// call this to force dispose the current provider
  /// ```dart
  /// final counterProvider = SimpleProvider.autoDispose<CounterController>(
  ///   (ref) {
  ///     ref.onDispose(() {
  ///       print("counterProvider disposed");
  ///     });
  ///     return CounterController();
  ///   },
  /// );
  /// ```
  void dispose() {
    if (!disposed) {
      if (_disposableCallback != null) {
        _disposableCallback!();
      }
      _providerDisposeCallback();
      disposed = true;
    }
  }

  void Function()? _disposableCallback;

  /// called when the notifier linked to this reference is destroyed
  void onDispose(void Function() cb) {
    this._disposableCallback = cb;
  }
}
