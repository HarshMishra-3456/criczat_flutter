abstract class Failure {}

class ServerFailure extends Failure {}

class ToManyRequestFailure extends Failure {}

class NetworkFailue extends Failure {
  final bool isError;

  NetworkFailue({this.isError = true});
}

class BadRequestFailue extends Failure {
  final bool isRedeem;

  BadRequestFailue({this.isRedeem=false});
}

class AuthorizationFailure extends Failure {}

class CacheFailure extends Failure {}

class ModelErrorFailure extends Failure {}

class OtherFailure extends Failure {
  final bool isError;

  OtherFailure({this.isError = true});
}
