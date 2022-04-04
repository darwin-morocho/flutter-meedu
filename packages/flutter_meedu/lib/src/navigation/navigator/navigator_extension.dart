import 'package:flutter/widgets.dart' show BuildContext;

import 'navigator.dart';

/// BuildContext extension to get an instance of Navigator1
extension ContextNavigatorExt on BuildContext {
  // ignore: public_member_api_docs
  Navigator1 get navigator => Navigator1(this);
}
