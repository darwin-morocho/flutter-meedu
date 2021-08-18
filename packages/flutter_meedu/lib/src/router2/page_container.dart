import 'package:flutter/widgets.dart' show Page;
import 'route_data.dart';

class PageContainer {
  final Page page;
  final RouteData data;
  PageContainer(this.page, this.data);

  /// returns data.fullPath
  String get id => data.fullPath;
}
