import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/src/state/provider_filter.dart';
import 'package:meedu/meedu.dart';

typedef ScopedReader = T Function<T extends BaseNotifier>(BaseProvider<T> provider, [BaseFilter? filter]);

/// {@template meedu.consumerwidget}
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

  ///
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

  void _clearDependencies() {
    _dependencies.forEach((provider, listener) {
      provider.read.removeListener(listener, _isExternalBuild);
    });
    _dependencies = {};
  }

  T _reader<T extends BaseNotifier>(BaseProvider<T> target, [BaseFilter? filter]) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final insideDependencies = _dependencies.containsKey(target);

    // add a new listener if the provider is not into dependencies
    if (!insideDependencies) {
      if (target is SimpleProvider) {
        if (filter != null && !(filter is SimpleFilter)) {
          throw AssertionError('filter must be a SimpleFilter');
        }
        final controller = target.read as SimpleNotifier;
        final listener = (dynamic _) {
          final listeners = _ as List<String>;
          if (listeners.isNotEmpty) {
            // if the update method was called with ids
            //  if the current MeeduBuilder id is inside the listeners
            if (filter != null) {
              for (final String id in (filter as SimpleFilter).ids) {
                if (listeners.contains(id)) {
                  _rebuild();
                  break;
                }
              }
            }
          } else {
            // update the widget if  listeners is empty
            _rebuild();
          }
        };
        controller.addListener(listener);
        _dependencies[target] = listener;
      } else {
        if (filter != null && !(filter is StateFilter)) {
          throw AssertionError('filter must be a StateFilter');
        }
        final stateTarget = (target as StateProvider);
        final controller = stateTarget.read;
        final listener = (Object? newState) {
          // if the buildWhen param is defined
          if (filter != null) {
            final buildWhen = (filter as StateFilter).buildWhen;

            /// check if the condition allows the rebuild
            if (buildWhen(stateTarget.oldState, newState)) {
              _rebuild();
            }
          } else {
            _rebuild();
          }
          stateTarget.setOldState(newState);
        };
        controller.addListener(listener);
        _dependencies[target] = listener;
      }
    }
    return target.read;
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _reader);
  }
}
