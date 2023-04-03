import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:store_app/common/error_handling/app_exception.dart';
import 'package:store_app/common/error_handling/check_exceptions.dart';
import 'package:store_app/config/constants.dart';

class HomeApiProvider {
  
  Dio dio;

  HomeApiProvider(this.dio);


   dynamic callHomeData(lat, lon) async {
    final response = await dio.get(
      "${Constants.baseUrl}/mainData" , queryParameters: {
        'lat' : lat,
        'lon' : lon
      }).onError((DioError error, stackTrace)  {
        return CheckExceptions.response(error.response!); //using error handling
      });

    log(response.toString());

    return response;
  }
}