import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:store_app/config/constants.dart';

class HomeApiProvider {
  
  Dio dio;

  HomeApiProvider(this.dio);


   dynamic callHomeData() async {
    final response = await dio.get(
      "${Constants.baseUrl}/mainData");

    log(response.toString());

    return response;
  }
}