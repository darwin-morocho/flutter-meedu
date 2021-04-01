import 'package:flutter/widgets.dart';
import 'package:meedu/meedu.dart';

typedef _ScopedReader = T Function<T extends BaseController>(BaseProvider<T> provider);

abstract class ConsumerWidget extends StatefulWidget {
  const ConsumerWidget({Key? key}) : super(key: key);

  @override
  _ConsumerState createState() => _ConsumerState();

  Widget build(BuildContext context, _ScopedReader watch);
}

class _ConsumerState extends State<ConsumerWidget> {
  Widget? _buildCache;
  Map<BaseProvider, ListenerCallback> _dependencies = {};

  // initialized at true for the first build
  bool _isExternalBuild = true;

  @override
  void initState() {
    super.initState();
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
    _buildCache = null;
    (context as Element).markNeedsBuild();
  }

  @override
  void dispose() {
    _dependencies.forEach((provider, listener) {
      provider.controller.removeListener(listener);
    });
    super.dispose();
  }

  T _reader<T extends BaseController>(BaseProvider<T> target) {
    _dependencies.putIfAbsent(target, () {
      if (target is SimpleProvider) {
        final controller = target.controller as SimpleController;
        final listener = (dynamic _) {
          final listeners = _ as List<String>;
          if (listeners.isNotEmpty) {
            // if the update method was called with ids
            // if the current MeeduBuilder id is inside the listeners
            for (final String id in (target as SimpleProvider).ids) {
              if (listeners.contains(id)) {
                _rebuild();
                break;
              }
            }
          } else {
            // update the widget if  listeners is empty
            _rebuild();
          }
        };
        controller.addListener(listener);
        return listener as void Function(dynamic);
      } else {
        final stateTarget = (target as StateProvider);
        final controller = stateTarget.controller;
        final listener = (Object? newState) {
          final buildWhen = stateTarget.buildWhen;
          // if the buildWhen param is defined
          if (buildWhen != null) {
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
        return listener;
      }
    });

    return target.controller;
  }

  @override
  Widget build(BuildContext context) {
    if (_buildCache != null) {
      return _buildCache!;
    }
    return _buildCache = widget.build(context, _reader);
  }
}
