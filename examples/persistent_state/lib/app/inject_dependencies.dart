import 'package:flutter_meedu/meedu.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistent_state/app/data/data_source/remote/cities_service.dart';
import 'package:persistent_state/app/data/repositories_impl/cities_repository.dart';
import 'package:persistent_state/app/domain/repositories/cities_repository.dart';

Future<void> injectDependencies() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('states');
  Get.put<Box>(box);
  Get.lazyPut<CitiesRepository>(
    () => CitiesRepositoryImpl(
      CitiesService(),
    ),
  );
}
