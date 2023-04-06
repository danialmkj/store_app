import 'package:dio/dio.dart';
import 'package:store_app/common/error_handling/app_exception.dart';
import 'package:store_app/common/error_handling/check_exceptions.dart';
import 'package:store_app/common/params/sign_up_params.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_auth/data/data_source/auth_api_provider.dart';
import 'package:store_app/features/feature_auth/data/models/login_with_sms_model.dart';

import '../data/models/code_model.dart';
import '../data/models/sign_up_model.dart';

class AuthRepository{

  AuthApiProvider authApiProvider;

  AuthRepository(this.authApiProvider);


  //call fetch Sign Up Data
  Future<DataState<SignupModel>> fetchSingUpData(SingUpParams singUpParams) async {

    try {
      
      Response response  = await authApiProvider.callSignUp(singUpParams);

      if (response.data['status'].toString() == "success") {

        SignupModel  signupModel = SignupModel.fromJson(response.data);

        return DataSuccess(signupModel);
        
      } else {
        return DataFailed(response.data['message']);
      }

    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  //call fetch Login with Sms
  Future<DataState<LoginWithSmsModel>> fetchLoginWithSMS(phoneNumber) async {

    try {
      
      Response response  = await authApiProvider.callLoginWithSMS(phoneNumber);

      if (response.data['status'].toString() != "error") {

        LoginWithSmsModel  loginWithSmsModel = LoginWithSmsModel.fromJson(response.data);

        return DataSuccess(loginWithSmsModel);
        
      } else {
        return DataFailed(response.data['message']);
      }

    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  //call fetch code check Data
  Future<DataState<CodeModel>> fetchCodeCheckData(code) async {
    try {
      
      Response response  = await authApiProvider.callCodeCheck(code);

        CodeModel   codeModel = CodeModel .fromJson(response.data);

        return DataSuccess(codeModel);
        
    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }


  //call fetch Register code check Data
  Future<DataState<LoginWithSmsModel>> fetchRegisterCodeCheckData(code) async {
    try {
      
      Response response  = await authApiProvider.callRegisterCodeCheck(code);

      if (response.data['status'].toString() == "success" ) {

         LoginWithSmsModel  loginWithSmsModel = LoginWithSmsModel.fromJson(response.data);

        return DataSuccess(loginWithSmsModel);
        
      } else {
         return DataFailed(response.data["message"]);

      }

    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }

}