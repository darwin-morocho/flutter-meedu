import 'dart:convert';

import 'package:flutter_meedu/meedu.dart';
import 'package:hive/hive.dart';

class MyPersistentStorage implements PersistentStateStorage {
  final Box _box = Get.find();

  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }

  @override
  Future<void> deleteAll() {
    return _box.clear();
  }

  @override
  Json? get(String key) {
    final dataAsString = _box.get(key);
    if (dataAsString != null) {
      return jsonDecode(dataAsString);
    }
    return null;
  }

  @override
  Future<void> save(String key, Json json) {
    return _box.put(
      key,
      jsonEncode(json),
    );
  }
}
