part of 'base_provider.dart';

class SimpleProvider<T extends SimpleNotifier> extends BaseProvider<T> {
  SimpleProvider(
    _LazyCallback<T> create, {
    bool autoDispose = false,
  }) : super(create, autoDispose: autoDispose);

  @override
  T get read {
    final created = Get.i.has<T>(tag: meeduProviderTag);
    if (created) {
      return Get.i.find<T>(tag: meeduProviderTag);
    }
    final ref = ProviderReference();
    final notifier = _create(ref);
    Get.i.put<T>(notifier, tag: meeduProviderTag);
    _initialized = true;
    return notifier;
  }
}
