import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

class HTTPHeader {
  static final String contentType = "Content-Type";
  static final String accept = "Accept";
}

class HTTPValue {
  static final String contentJson = "application/json";
  // static final String baseURL = "http://192.168.0.54:8080/";
  // static final String baseURL = "http://192.168.16.89:8080/";

  static final String baseURL = "http://tt1220-001-site1.ntempurl.com";
}

@module
abstract class DioManager {
  @factoryMethod
  Dio createDio() {
    final timeout = Duration(seconds: 60);

    final dio = Dio();

    final headers = <String, dynamic>{
      HTTPHeader.contentType: HTTPValue.contentJson,
      HTTPHeader.accept: HTTPValue.contentJson,
    };

    dio.options = BaseOptions(
      baseUrl: HTTPValue.baseURL,
      sendTimeout: timeout,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      headers: headers,
    );

    dio.interceptors.add(AwesomeDioInterceptor());

    return dio;
  }
}
