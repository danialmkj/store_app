// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:store_app/common/error_handling/check_exceptions.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_home/data/data_source/home_api_provider.dart';
import 'package:store_app/features/feature_home/data/models/home_model.dart';

import '../../../common/error_handling/app_exception.dart';

class HomeRepository {
  HomeApiProvider apiProvider;

  HomeRepository({required this.apiProvider});

  //call api from homeApi and fetch StatusCode
  Future<DataState<HomeModel>> fetchHomeData(lat, lon) async {
    try {
      Response response = await apiProvider.callHomeData(lat, lon);

      HomeModel homeModel = HomeModel.fromJson(response.data);

      return DataSuccess(homeModel);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }
}
