part of 'base_provider.dart';

class ProviderContainer {
  final int providerHashCode;
  final BaseNotifier notifier;
  final ProviderReference reference;
  final String? routeName;
  final bool autoDispose;

  ProviderContainer({
    required this.providerHashCode,
    required this.notifier,
    required this.reference,
    required this.autoDispose,
    required this.routeName,
  });
}
