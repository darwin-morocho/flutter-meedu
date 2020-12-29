import 'package:meta/meta.dart' show protected;
import 'package:flutter/widgets.dart' show BuildContext, StatelessWidget, Key, Widget;
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import '../builders/state_builder.dart';

typedef _BuildWhen<S> = bool Function(S, S);

abstract class StateWidget<T extends StateController<S>, S> extends StatelessWidget {
  /// override this value if you have a tag in your Provider
  @protected
  String get tag => null;

  /// override this value if you want updates by the buildWhen condition
  @protected
  _BuildWhen<S> get buildWhen => null;

  const StateWidget({Key key}) : super(key: key);

  /// get the controller
  T get controller => Get.i.find<T>(tag: tag);

  S get state => controller.state;

  /// called every time that the widget needs rebuild
  Widget buildChild(BuildContext context, T controller);

  Widget build(BuildContext context) {
    return StateBuilder<T, S>(
      tag: this.tag,
      buildWhen: this.buildWhen,
      builder: (controller) => buildChild(
        context,
        controller,
      ),
    );
  }
}
