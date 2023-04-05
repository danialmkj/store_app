import 'package:dio/dio.dart';
import 'package:store_app/common/params/sign_up_params.dart';
import 'package:store_app/features/feature_auth/data/data_source/auth_api_provider.dart';

class AuthRepository{

  AuthApiProvider authApiProvider;

  AuthRepository(this.authApiProvider);


  Future<void> fetchSingUpData(SingUpParams singUpParams) async {

    try {
      
      Response response  = await authApiProvider.callSignUp(singUpParams);

      if (response.data['status'].toString() == "success") {
        
      } else {
        
      }

    } catch (e) {
      
    }
  }


}