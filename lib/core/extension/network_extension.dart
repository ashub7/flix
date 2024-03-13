import 'dart:io';

import 'package:dio/dio.dart';
import '../errors/api_failure.dart';

extension ErrorMapper on Exception{
  ApiFailure mapToFailure(){
    if(this is DioException){
      final error = (this as DioException).error;
      if(error is SocketException){
        return ApiFailure("No Internet access");
      }
      return ApiFailure("Something went wrong");
    }else{
      return ApiFailure("Something went wrong");
    }
  }
}