class WatchFilter<T, S> {
  /// only use this with a StateNotifier
  /// listen and rebuild a [Consumer] using a value returned for this callback
  final BuildWhen<S>? when;

  /// only use this with a SimpleNotifier
  /// listen and rebuild a [Consumer] using a list of String
  final List<String>? ids;

  /// only use this with a SimpleNotifier
  /// listen and rebuild a [Consumer] using a value returned for this callback
  final BuildBySelect<T, S>? select;

  WatchFilter({
    this.when,
    this.ids,
    this.select,
  });
}

typedef BuildWhen<S> = bool Function(S prev, S current);
typedef BuildBySelect<T, S> = S Function(T);
