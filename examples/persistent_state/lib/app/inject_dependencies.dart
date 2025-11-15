import 'package:flutter_meedu/providers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistent_state/app/data/data_source/remote/cities_service.dart';
import 'package:persistent_state/app/data/repositories_impl/cities_repository.dart';
import 'package:persistent_state/app/domain/repositories/cities_repository.dart';

final boxProvider = Provider.arguments<Box, Box>(
  (ref) => ref.arguments,
);

final citiesProvider = Provider<CitiesRepository>(
  (ref) => CitiesRepositoryImpl(
    CitiesService(),
  ),
);

Future<void> injectDependencies() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('states');
  boxProvider.setArguments(box);
}
