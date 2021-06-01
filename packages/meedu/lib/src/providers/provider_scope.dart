import 'provider_container.dart';

abstract class ProviderScope {
  /// save the notifiers in one instance of ProviderContainer
  static final containers = <int, ProviderContainer>{};

  /// delete all providers from the ProviderScope
  static void clear() {
    for (final container in containers.values) {
      container.reference.dispose();
    }
    containers.clear();
  }
}
