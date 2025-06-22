class AppExceptions implements Exception {
  final String message;
  final int? statusCode;

  AppExceptions({required this.message, this.statusCode});

  @override
  String toString() {
    String output = 'Erro: $message';
    if (statusCode != null) {
      output += ' (Código: $statusCode)';
    }
    return output;
  }
}

class ServerException extends AppExceptions {
  ServerException({required super.message, super.statusCode});
}

class NetworkException extends AppExceptions {
  NetworkException({required super.message, super.statusCode});
}

class GenericException extends AppExceptions {
  GenericException({required super.message, super.statusCode});
}

class InvalidInputException extends AppExceptions {
  final String? code;
  InvalidInputException({required super.message, this.code});
}