part of 'base_provider.dart';

class ProviderReference {
  /// store arguements
  final dynamic arguments;

  /// callback to be called when a provider is disposed
  final void Function() _providerDisposeCallback;

  /// the reference's callbac to be called when a provider is disposed
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
  void Function()? _disposableCallback;

  /// check if the _disposableCallback method call called before
  bool _disposed = false;

  ProviderReference({
    this.arguments,
    required void Function() providerDisposeCallback,
  }) : _providerDisposeCallback = providerDisposeCallback;

  /// this method could be used to read a Notifier using the current provider
  /// ```dart
  /// final counterProvider = SimpleProvider.autoDispose<CounterController>(
  ///   (ref) {
  ///     final otherController = ref.read(otherProvider);
  ///     return CounterController();
  ///   },
  /// );
  /// ```
  T read<T extends BaseNotifier>(BaseProvider<T> provider) {
    return provider.read;
  }

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
    if (!_disposed) {
      if (_disposableCallback != null) {
        _disposableCallback!();
      }
      _providerDisposeCallback();
      _disposed = true;
    }
  }

  /// called when the notifier linked to this reference is destroyed
  void onDispose(void Function() cb) {
    _disposableCallback = cb;
  }
}
