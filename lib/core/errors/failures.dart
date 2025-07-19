import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: "Connection timeout");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: "Send timeout");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: "receive timeout");
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: "Bad certificate");
      case DioExceptionType.badResponse:
        // return ServerFailure(
        //   errMessage:
        //       dioError.response?.statusCode == 400
        //           ? dioError.response!.data["error"]
        //           : "Something went wrong",
        // );
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: "Request was canceled");
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: "No Internet connection");
      case DioExceptionType.unknown:
        return ServerFailure(errMessage: "Unexpected Error, Please try later");
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, Response? response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errMessage: response!.data["error"]);
    } else if (statusCode == 404) {
      return ServerFailure(
        errMessage: "Your request not found, Please try later!",
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errMessage: "Internal server error, Please try later",
      );
    } else {
      return ServerFailure(
        errMessage: "Opps There was an error, Please try again",
      );
    }
  }
}
