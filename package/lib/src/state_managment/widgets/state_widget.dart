import 'package:flutter/widgets.dart'
    show BuildContext, StatelessWidget, Key, Widget;
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';

typedef _BuildWhen<S> = bool Function(S, S);

abstract class StateWidget<T extends StateController<S>, S>
    extends StatelessWidget {
  /// override this value if you have a tag in your Provider
  final String tag;

  /// override this value if you want updates by the buildWhen condition
  final _BuildWhen<S> buildWhen;

  const StateWidget({Key key, this.tag, this.buildWhen}) : super(key: key);

  /// get the controller
  T get controller => Get.i.find<T>(tag: tag);

  S get state => controller.state;

  /// called every time that the widget needs rebuild
  Widget buildChild(BuildContext context, T controller);

  Widget build(BuildContext context) {
    return StateBuilder<T, S>(
      buildWhen: this.buildWhen,
      builder: (controller) => buildChild(
        context,
        controller,
      ),
    );
  }
}
