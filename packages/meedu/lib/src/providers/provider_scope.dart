import 'provider_container.dart';

class ProviderScope {
  ProviderScope._();

  static ProviderScope? _instance;
  static bool get initialized => _instance != null;

  static ProviderScope get instance {
    _instance ??= ProviderScope._();
    return _instance!;
  }

  /// save the notifiers in one instance of ProviderContainer
  final containers = <int, ProviderContainer>{};

  /// delete all providers from the ProviderScope
  void removeAll() {
    for (final container in containers.values) {
      container.reference.dispose();
    }
    containers.clear();
  }

  /// delete all providers from the ProviderScope
  static void clear() {
    if (initialized) {
      instance.removeAll();
    }
  }
}
