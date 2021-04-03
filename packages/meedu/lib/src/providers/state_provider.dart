part of 'base_provider.dart';

class StateProvider<T extends StateNotifier<S>, S> extends BaseProvider<T> {
  late S _oldState;
  S get oldState => _oldState;

  StateProvider(
    _LazyCallback<T> create, {
    bool autoDispose = false,
  }) : super(create, autoDispose: autoDispose);

  void setOldState(S newState) {
    _oldState = newState;
  }

  @override
  T get read {
    final created = Get.i.has<T>(tag: meeduProviderTag);
    if (created) {
      return Get.i.find<T>(tag: meeduProviderTag);
    }
    final ref = ProviderReference();
    final notifier = _create(ref);
    Get.i.put<T>(notifier, tag: meeduProviderTag);
    this.setOldState(notifier.state);
    _initialized = true;
    return notifier;
  }
}
