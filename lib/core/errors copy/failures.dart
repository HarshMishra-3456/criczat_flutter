
abstract class Failure  {
}

// General failures
class ServerFailure extends Failure {}

class ToManyRequestFailure extends Failure {}

class NetworkFailue extends Failure {}
class BadRequestFailue extends Failure {}

class AuthorizationFailure extends Failure{}

class CacheFailure extends Failure {}
class ModelErrorFailure extends Failure{}

class OtherFailure extends Failure {}
