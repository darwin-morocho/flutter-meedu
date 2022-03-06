import '../models/city.dart';

abstract class CitiesRepository {
  Future<List<City>?> getAll();
}
