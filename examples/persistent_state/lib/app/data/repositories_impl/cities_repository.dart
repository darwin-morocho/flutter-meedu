import 'package:persistent_state/app/data/data_source/remote/cities_service.dart';
import 'package:persistent_state/app/domain/models/city.dart';
import 'package:persistent_state/app/domain/repositories/cities_repository.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesService _service;

  CitiesRepositoryImpl(this._service);

  @override
  Future<List<City>?> getAll() {
    return _service.get();
  }
}
