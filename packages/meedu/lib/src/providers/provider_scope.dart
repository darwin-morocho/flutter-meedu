import 'provider_container.dart';

abstract class ProviderScope {
  /// save the notifiers in one instance of ProviderContainer
  static final containers = <int, ProviderContainer>{};
}
