import 'dart:io';

import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:dio/dio.dart';
import 'package:store_app/common/error_handling/check_exceptions.dart';
import 'package:store_app/common/params/sign_up_params.dart';
import 'package:store_app/config/constants.dart';

class AuthApiProvider {
  
  final Dio dio;

  AuthApiProvider(this.dio);


  //call SignUp Method
  dynamic callSignUp(SingUpParams singUpParams) async {
    try {

      final response = dio.get('${Constants.baseUrl}/register',
       queryParameters: {
        "name" :  singUpParams.userName,
        "mobile" :  singUpParams.phoneNumber,
      });

      print(response.toString());

      return response;
      
    } on DioError catch (e) {
        return CheckExceptions.response(e.response!);
    }
  }



  //call Login with Sms
  dynamic callLoginWithSMS(phoneNumber) async{
    try {

      final response = dio.get('${Constants.baseUrl}/auth/loginWithSms',
      queryParameters: {
        "mobile" : phoneNumber,
        if(Platform.isAndroid)
        'hash' : (await AndroidSmsRetriever.getAppSignature()) //we should use this line to find sms which is for us
      } );

      print(response.toString());

      return response;
      
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }

  }




  // call Code Check
   dynamic callCodeCheck(code) async{

   try {

      final response = dio.get('${Constants.baseUrl}/auth/loginWithSms/check',
      queryParameters: {
        "code" : code,
      } );

      print(response.toString());

      return response;
      
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
   }


   //call Register Code Check
  dynamic callRegisterCodeCheck(mobile) async{
     try{
      final response = await dio.post(
          "${Constants.baseUrl}/auth/sendcode",
          queryParameters: {
            "mobile" : mobile,
            if(Platform.isAndroid)
              'hash': (await AndroidSmsRetriever.getAppSignature())
          }
      );
      print(response.toString());

      return response;

    }on DioError catch(e){
      return CheckExceptions.response(e.response!);
    }
  }
   
}