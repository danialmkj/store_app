// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_home/data/data_source/home_api_provider.dart';
import 'package:store_app/features/feature_home/data/models/home_model.dart';

class HomeRepository {
  HomeApiProvider apiProvider;

  HomeRepository({required this.apiProvider});

  //call api from homeApi and fetch StatusCode
  Future<DataState<HomeModel>> fetchHomeData() async {
    try {
      Response response = await apiProvider.callHomeData();

      if (response.statusCode == 200) {
        HomeModel homeModel = HomeModel.fromJson(response);

        return DataSuccess(homeModel);
      } else {
        return DataFailed('problem in status code');
      }
    } catch (e) {
      return DataFailed('error in DataFailed is : '+e.toString());
    }
  }
}
