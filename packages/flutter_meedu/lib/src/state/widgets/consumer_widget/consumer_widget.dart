import 'package:flutter/widgets.dart';
import 'package:meedu/meedu.dart';
import 'watch_filter.dart';

part 'utils.dart';

/// A function to read SimpleProvider or a StateProvider and subscribe to the events.
///
/// [provider] must be a SimpleProvider or a BaseProvider.
///
/// [filter] one instance of WatchFilter, use this to avoid unnecessary rebuilds
typedef ScopedReader = T Function<T, S>(BaseProvider<T> provider, [WatchFilter<T, S>? filter]);

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
  void deactivate() {
    _clearDependencies();
    super.deactivate();
  }

  @override
  void dispose() {
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

  /// read a Notifier from one provider and subscribe the widget to the changes of this Notifier.
  ///
  /// [filter] optional parameter to avoid unnecessary rebuilds
  T _reader<T, S>(BaseProvider<T> provider, [WatchFilter<T, S>? filter]) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final insideDependencies = _dependencies.containsKey(provider);

    // add a new listener if the provider is not into dependencies
    if (!insideDependencies) {
      if (provider is SimpleProvider) {
        _dependencies[provider] = createSimpleProviderListener<T, S>(
          provider: provider as SimpleProvider<T>,
          rebuild: _rebuild,
          buildByIds: filter?.ids,
          buildBySelect: filter?.select,
        );
      } else {
        _dependencies[provider] = createStateProviderListener<S>(
          provider: provider as StateProvider<StateNotifier<S>, S>,
          rebuild: _rebuild,
          buildWhen: filter?.when,
          // filter: filter as StateFilter?,
        );
      }
    }
    return provider.read;
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _reader);
  }
}
