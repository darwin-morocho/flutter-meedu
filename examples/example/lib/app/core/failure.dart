abstract class Failure implements Exception{}


class ServerException implements Failure {
  final int statusCode;

  ServerException(this.statusCode);
}
