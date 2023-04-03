// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_home/data/data_source/home_api_provider.dart';
import 'package:store_app/features/feature_home/data/models/home_model.dart';

class HomeRepository {
  HomeApiProvider apiProvider;

  HomeRepository({required this.apiProvider});

  //call api from homeApi and fetch StatusCode
 //call api from homeApi and fetch StatusCode
  Future<DataState<HomeModel>> fetchHomeData(lat, lon) async {
    //try {
      Response response = await apiProvider.callHomeData(lat, lon);

      if (response.statusCode == 200) {
        
      print('response status code is ' + response.statusCode.toString());
  
        HomeModel homeModel = HomeModel.fromJson(response.data);

        print('one of data is ' + homeModel.data.banners[0].image );

        return DataSuccess(homeModel);
      } else {
         return DataFailed('problem in status code');
       }
    // } catch (e) {
    //   return DataFailed('error in DataFailed is : '+e.toString());
    // }
  }
}
