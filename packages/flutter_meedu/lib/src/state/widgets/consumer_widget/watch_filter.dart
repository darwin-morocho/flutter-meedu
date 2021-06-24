part of 'consumer_widget.dart';

typedef BuildWhen<S> = bool Function(S prev, S current);
typedef BuildBySelect<T, S> = S Function(T);

class Target<Notifier, S> extends Provider<Notifier> {
  final BaseProvider<Notifier> provider;
  final BuildBySelect<Notifier, Object?>? select;
  final BuildBySelect<S, Object?>? stateSelect;
  final List<String>? ids;
  final BuildWhen<S>? when;
  Target({
    required this.provider,
    this.select,
    this.ids,
    this.when,
    this.stateSelect,
  });
}

extension SimpleProviderExt<Notifier> on SimpleProvider<Notifier> {
  Target<Notifier, List> select(BuildBySelect<Notifier, Object?> cb) {
    return Target(provider: this, select: cb);
  }

  Target<Notifier, List> ids(List<String> Function() cb) {
    return Target(provider: this, ids: cb());
  }
}

extension StateProviderExt<Notifier extends StateNotifier<S>, S> on StateProvider<Notifier, S> {
  Target<Notifier, S> when(BuildWhen<S> cb) {
    return Target<Notifier, S>(provider: this, when: cb);
  }

  Target<Notifier, S> select(BuildBySelect<S, Object?> cb) {
    return Target(provider: this, stateSelect: cb);
  }
}
