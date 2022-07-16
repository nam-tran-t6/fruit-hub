class RequestException implements Exception {
  final message;

  RequestException(this.message);
}

class FetchDataException extends RequestException {
  FetchDataException(message) : super(message);
}

class BadRequestException extends RequestException {
  BadRequestException(message) : super(message);
}

class UnauthorizedException extends RequestException {
  UnauthorizedException(message) : super(message);
}

class NoInternetException extends RequestException {
  NoInternetException(message) : super(message);
}

class InternalServerException extends RequestException {
  InternalServerException(message) : super(message);
}
