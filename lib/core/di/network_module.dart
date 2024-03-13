import 'package:dio/dio.dart';
import 'package:flix/core/utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule{
  @singleton
  Dio provideDio(){
    final dio = Dio()..options= BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)
    );
    dio.interceptors.add(PrettyDioLogger(
      request: false,
      requestBody: false,
      requestHeader: false,
      responseBody: false
    ));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.queryParameters["api_key"] = Constants.apiKey;
      return handler.next(options);
    },));
    return dio;
  }
}