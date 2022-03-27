import 'package:flutter/widgets.dart' show BuildContext, State;

import 'navigator.dart';

/// a mixin to easyly get a Navigator1 from a class that extends of State
mixin StateNavigatorMixin on State {
  // ignore: public_member_api_docs
  Navigator1 get navigator => context.navigator;
}

/// BuildContext extension to get an instance of Navigator1
extension ContextNavigatorExt on BuildContext {
  // ignore: public_member_api_docs
  Navigator1 get navigator => Navigator1(this);
}
