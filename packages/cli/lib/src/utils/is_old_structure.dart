import 'dart:io';

import 'base_path.dart';

bool isOldStructure() {
  return Directory('${basePath}lib/app/ui').existsSync();
}
