import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/common/utils/prefs_operator.dart';
import 'package:store_app/features/feature_home/data/data_source/home_api_provider.dart';
import 'package:store_app/features/feature_home/repositories/home_repository.dart';
import 'package:store_app/features/feature_product/data/data_source/category_api_provider.dart';
import 'package:store_app/features/feature_product/repository/category_repository.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
// create instance of dio
  locator.registerSingleton<Dio>(Dio());

// create instance of shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<PrefsOperator>(PrefsOperator());

// api provider
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider(locator()));
  locator
      .registerSingleton<CategoryApiProvider>(CategoryApiProvider(locator()));

// repository
  locator.registerSingleton<HomeRepository>(
      HomeRepository(apiProvider: locator()));
  locator.registerSingleton<CategoryRepository>(
      CategoryRepository(categoryApiProvider: locator()));
}
