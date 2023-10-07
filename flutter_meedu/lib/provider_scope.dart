import 'package:flutter_meedu/flutter_meedu.dart';

class ProviderScope {
  ProviderScope._();

  static ProviderScope? _instance;
  static bool get initialized => _instance != null;

  static ProviderScope get instance {
    _instance ??= ProviderScope._();
    return _instance!;
  }

  /// save the notifiers in one instance of ProviderContainer
  final _providers = <int, BaseProvider>{};

  /// delete all providers from the ProviderScope
  void removeAll() {
    for (final provider in _providers.values) {
      provider.dispose();
    }
    _providers.clear();
  }

  void add(BaseProvider provider) {
    _providers[provider.hashCode] = provider;
  }

  /// delete all providers from the ProviderScope
  static void clear() {
    if (initialized) {
      instance.removeAll();
    }
  }
}
