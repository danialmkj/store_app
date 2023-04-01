import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/common/utils/prefs_operator.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {

// create instance of dio
  locator.registerSingleton<Dio>(Dio());  

// create instance of shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);  
  locator.registerSingleton<PrefsOperator>(PrefsOperator());  
}