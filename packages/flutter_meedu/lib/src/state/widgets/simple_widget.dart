import 'package:flutter/widgets.dart'
    show BuildContext, StatelessWidget, Key, Widget;
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import '../builders/simple_builder.dart';

abstract class SimpleWidget<T extends SimpleNotifier> extends StatelessWidget {
  /// override this value if you have a tag in your Provider
  String? get tag => null;

  /// override this value if you want updates by id
  String? get id => null;

  const SimpleWidget({Key? key}) : super(key: key);

  /// get the controller
  T get controller => Get.i.find<T>(tag: tag);

  /// called every time that the widget needs rebuild
  Widget buildChild(BuildContext context, T controller);

  Widget build(BuildContext context) {
    return SimpleBuilder<T>(
      id: this.id,
      tag: this.tag,
      builder: (context, controller) => buildChild(
        context,
        controller,
      ),
    );
  }
}
