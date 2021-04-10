import 'package:flutter/widgets.dart';
import 'package:meedu/meedu.dart';

part 'utils.dart';
part 'provider_filter.dart';

/// A function to read SimpleProvider or a StateProvider and subscribe to the events.
///
/// [provider] must be a SimpleProvider or a BaseProvider.
///
/// [filter] one instance of SimpleFilter or StateFilter, use this to avoid unnecessary  updates
typedef ScopedReader = T Function<T, S>(BaseProvider<T> provider);

/// {@template meedu.consumerwidget}
/// A base-class for widgets that wants to listen to providers
/// ```dart
/// class Example extends ConsumerWidget {
///   const Example({Key? key}): super(key: key);
///
///   @override
///   Widget build(BuildContext context, ScopedReader watch) {
///     final value = watch(myProvider);
///
///   }
/// }
/// ```
/// {@endtemplate}
abstract class ConsumerWidget extends StatefulWidget {
  const ConsumerWidget({Key? key}) : super(key: key);
  Widget build(BuildContext context, ScopedReader watch);

  @override
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState extends State<ConsumerWidget> {
  Map<BaseProvider, ListenerCallback> _dependencies = {};

  // initialized at true for the first build
  bool _isExternalBuild = true;

  /// used know when the first frame was redered
  bool _afterFirstLayout = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _afterFirstLayout = true;
    });
  }

  @override
  void didUpdateWidget(ConsumerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isExternalBuild = true;
  }

  @override
  void reassemble() {
    super.reassemble();
    _isExternalBuild = true;
  }

  /// force the widget update
  void _rebuild() {
    if (_afterFirstLayout) {
      (context as Element).markNeedsBuild();
    }
  }

  @override
  void dispose() {
    _clearDependencies();
    super.dispose();
  }

  /// clear the listeners for this widget
  void _clearDependencies() {
    _dependencies.forEach(
      (provider, listener) {
        if (provider.mounted) {
          provider.read.removeListener(listener);
        }
      },
    );
    _dependencies = {};
  }

  T _reader<T, S>(BaseProvider<T> target) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final insideDependencies = _dependencies.containsKey(target);

    // add a new listener if the provider is not into dependencies
    if (!insideDependencies) {
      if (target is SimpleProvider) {
        // if (filter != null && !(filter is SimpleFilter)) {
        //   throw AssertionError('filter must be a SimpleFilter');
        // }
        _dependencies[target] = createSimpleProviderListener<T>(
          provider: target as SimpleProvider<T>,
          rebuild: _rebuild,
          // filter: filter as SimpleFilter?,
        );
      } else {
        // if (filter != null && !(filter is StateFilter)) {
        //   throw AssertionError('filter must be a StateFilter');
        // }

        _dependencies[target] = createStateProviderListener<S>(
          provider: target as StateProvider<StateNotifier<S>, S>,
          rebuild: _rebuild,
          // filter: filter as StateFilter?,
        );
      }
    }
    return target.read;
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _reader);
  }
}

/// A function that can also listen to providers
///
/// See also [Consumer]
typedef ConsumerBuilder = Widget Function(
  BuildContext context,
  ScopedReader watch,
  Widget? child,
);

/// A widget to listen the events in a SimpleNotifier or StateNotifier
///
/// [builder]
/// [child] use this to pass a pre-built widget
class Consumer extends ConsumerWidget {
  final ConsumerBuilder builder;
  final Widget? child;

  Consumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return builder(context, watch, this.child);
  }
}
