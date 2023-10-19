// ignore_for_file: public_member_api_docs
part of 'consumer_widget.dart';

/// A function that can also listen to providers
///
/// See also [Consumer]
typedef ConsumerBuilder = Widget Function(
  BuildContext context,
  BuilderRef ref,
  Widget? child,
);

/// A widget to listen the events in a SimpleNotifier or StateNotifier
///
/// [builder]
/// [child] use this to pass a pre-built widget
class Consumer extends ConsumerWidget {
  const Consumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  /// callback that exposes the [BuilderRef] to decide
  /// when the consumer must be rebuilded
  final ConsumerBuilder builder;

  /// a pre-cached widget that it won't be
  /// rebuilded every time that the builder is called
  final Widget? child;

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    return builder(
      context,
      ref,
      child,
    );
  }
}

extension _ConsumerWatchExtension on ConsumerStatefulElement {
  N _buildWatcher<N extends StateNotifier<S>, S>({
    required m.BaseStateNotifierProvider<N, S> providerOrFilter,
    required void Function(N notifier) callback,
    required String? tag,
    required bool isListener,
  }) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final filter = providerOrFilter is FilteredProvider
        ? providerOrFilter as FilteredProvider<N, S>
        : null;

    late N notifier;

    if (filter != null) {
      // If [providerOrFilter] is a value gotten from .select or .when
      notifier = switch (filter) {
        SelectFilteredProvider filter => filter.notifier,
        WhenFilteredProvider filter => filter.notifier,
      } as N;
    } else {
      // if [providerOrFilter] is a  a [StateProvider]
      notifier =
          (providerOrFilter as m.ListeneableProvider).read(tag: tag) as N;
    }

    late final Map<StateNotifier, Function> map;

    if (!isListener) {
      map = _builders;
    } else {
      map = filter == null
          ? _listeners
          : switch (filter) {
              SelectFilteredProvider _ => _selectListeners,
              WhenFilteredProvider _ => _whenListeners,
            };
    }

    final insideDependencies = map.containsKey(notifier);

    // if there is not a listener for the current provider
    if (!insideDependencies) {
      // if the data passed to the watch function
      // was gotten using the .ids, .select or .when methods
      if (filter != null) {
        filter.reaction = callback;
        filter.createListener();
        map[notifier] = filter.listener;
        notifier.addListener(filter.listener);
      } else {
        // ignore: prefer_function_declarations_over_variables
        final _ListenerCallback listener = (_) => callback(notifier);
        map[notifier] = listener;
        notifier.addListener(listener);
      }
      // add the listener to the current notifier
    }
    return notifier; // coverage:ignore-line
  }
}
