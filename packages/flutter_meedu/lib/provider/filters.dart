import 'package:meedu/notifiers.dart';
import 'package:meedu/providers.dart';

typedef SelectCallback<S, R> = R Function(S);
typedef BuildWhenCallback<S> = bool Function(S prev, S current);

sealed class FilteredProvider<N, S> {
  FilteredProvider({required this.notifier});

  final N notifier;

  /// function to rebuild the Consumer
  void Function(N notifier)? reaction;

  late void Function(S) listener;
  void createListener();
}

class SelectFilteredProvider<N extends StateNotifier<S>, S, R>
    extends FilteredProvider<N, S> implements BaseStateNotifierProvider<N, S> {
  SelectFilteredProvider({
    required super.notifier,
    required this.callback,
    required this.listenWhenTheCallbackReturnsTrue,
  });

  /// callback defined when a filter is used
  final SelectCallback<S, R> callback;

  /// if the filter is a selected and we only want to
  /// rebuild the consumer when the callback returns true
  final bool listenWhenTheCallbackReturnsTrue;

  /// used to store the value returned by .select or .when
  late R selectValue;

  @override
  void createListener() => createSelectListener(this);
}

class WhenFilteredProvider<N extends StateNotifier<S>, S>
    extends FilteredProvider<N, S> implements BaseStateNotifierProvider<N, S> {
  WhenFilteredProvider({
    required super.notifier,
    required this.callback,
  });

  /// callback defined when a filter is used
  final BuildWhenCallback<S> callback;

  @override
  void createListener() => createWhenListener(this);
}

extension StateNotifierProviderExtension<N extends StateNotifier<S>, S, A>
    on ListeneableProvider<N, S, A> {
  SelectFilteredProvider<N, S, R> select<R>(
    SelectCallback<S, R> callback, {
    String? tag,
    bool booleanCallback = false,
  }) {
    return SelectFilteredProvider(
      callback: callback,
      notifier: read(tag: tag),
      listenWhenTheCallbackReturnsTrue: booleanCallback,
    );
  }

  WhenFilteredProvider<N, S> when<R>(
    BuildWhenCallback<S> callback, {
    String? tag,
    bool booleanCallback = false,
  }) {
    return WhenFilteredProvider(
      callback: callback,
      notifier: read(tag: tag),
    );
  }
}

/// create the listener for provider.select filter (StateProvider)
void createSelectListener<N extends StateNotifier<S>, S, R>(
  SelectFilteredProvider<N, S, R> filter,
) {
  R prevValue = filter.callback(filter.notifier.state);
  filter.selectValue = prevValue;

  filter.listener = (newState) {
    final value = filter.callback(filter.notifier.state);
    if (filter.listenWhenTheCallbackReturnsTrue) {
      assert(
        value is bool,
        'The value returned by the callback must be a boolean because '
        'listenWhenTheCallbackReturnsTrue is true',
      );
    }

    filter.selectValue = value;

    bool allowRebuild = false;
    if (value is bool && filter.listenWhenTheCallbackReturnsTrue) {
      allowRebuild = value;
    } else if (prevValue != value) {
      allowRebuild = true;
    }

    // check if the value has changed
    if (allowRebuild && filter.reaction != null) {
      filter.reaction!(filter.notifier);
    }
    prevValue = value;
  };
}

/// create the listener for provider.when filter
void createWhenListener<N extends StateNotifier<S>, S>(
  WhenFilteredProvider<N, S> filter,
) {
  final notifier = filter.notifier;
  filter.listener = (newState) {
    // rebuild the Consumer using the boolean returned by the callback
    final allowRebuild = filter.callback(notifier.oldState, newState);
    if (allowRebuild) {
      filter.reaction?.call(notifier);
    }
  };
}
