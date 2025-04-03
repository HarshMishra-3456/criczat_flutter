class ServerException implements Exception {}

class AuthorizationException implements Exception {
  String error;

  AuthorizationException({this.error = 'User Unauthorized'});
}

class TooManyRequestsException implements Exception {
  String error;

  TooManyRequestsException({this.error = 'Too Many Requests'});
}

class BadRequestException implements Exception {
  String error;

  BadRequestException({this.error = 'Something went wrong'});
}

class CacheException implements Exception {}
