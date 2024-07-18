import 'package:algorand_dart/src/exceptions/algorand_factory.dart';
import 'package:algorand_dart/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class AlgorandException implements Exception {
  final int errorCode;
  final int? statusCode;
  final String? _message;
  final Object? cause;

  AlgorandException({
    this.errorCode = 0,
    String? message,
    this.statusCode,
    this.cause,
  }) : _message = message;

  factory AlgorandException.fromDioException(DioException exception) {
    return AlgorandException(
      statusCode: exception.response?.statusCode,
      message: exception.message,
      cause: exception,
    );
  }

  String get message {
    final cause = this.cause;
    if (cause is! DioException) {
      return _message ?? '';
    }

    final dioCause = cause;
    final message = dioCause.response?.data?['message'];

    if (message is! String) {
      return _message ?? '';
    }

    return message;
  }

  AlgorandError? get error {
    return AlgorandFactory().tryParse(message);
  }
}
