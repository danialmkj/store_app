import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:store_app/config/constants.dart';

class HomeApiProvider {
  
  Dio dio;

  HomeApiProvider(this.dio);


   dynamic callHomeData(lat, lon) async {
    final response = await dio.get(
      "${Constants.baseUrl}/mainData" , queryParameters: {
        'lat' : lat,
        'lon' : lon
      });

    log(response.toString());

    return response;
  }
}