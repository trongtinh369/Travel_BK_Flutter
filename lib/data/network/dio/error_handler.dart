import 'package:booking_tour_flutter/data/network/dio/failure.dart';
import 'package:booking_tour_flutter/data/response/error_response.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(Object e) {
    var errorMessage = "Lỗi xảy ra trong quá trình gọi đến server";

    if (e is DioException) {
      try {
        var json = e.response?.data as Map<String, dynamic>;
        var errorResponse = ErrorResponse.fromJson(json);
        errorMessage = errorResponse.errorMessage ?? errorMessage;
        failure = Failure(code: -1, message: errorMessage);
      } catch (e) {
        failure = Failure(code: -1, message: errorMessage);
      }
    } else {
      failure = Failure(code: -1, message: errorMessage);
    }
  }
}
