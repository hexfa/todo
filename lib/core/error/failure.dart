import 'error_messages.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super(ErrorMessages.serverFailure);
}
