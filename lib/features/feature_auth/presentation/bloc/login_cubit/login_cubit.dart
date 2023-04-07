import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_auth/repository/auth_repository.dart';
import '../../../data/models/code_model.dart';
import '../../../data/models/login_with_sms_model.dart';

part 'login_state.dart';
part 'login_data_status.dart';
part 'code_check_status.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(LoginState(loginDataStatus: LoginDataInitial(), codeCheckStatus: CodeCheckInitial()));


  // method Load Login Sms
  Future<void> LoadLoginSms(phoneNumber)async{
    
    //emit Loading
    emit(state.copyWith(newLoginDataStatus: LoginDataLoading()));


    DataState dataState = await authRepository.fetchLoginWithSMS(phoneNumber);

    if (dataState is DataSuccess) {

      //emit complete
      emit(state.copyWith(newLoginDataStatus: LoginDataCompleted(dataState.data)));
    } else if(dataState is DataFailed){
      
      //emit error
      emit(state.copyWith(newLoginDataStatus: LoginDataError(dataState.error!)));
    }
  }



  // method Load Code Check
  Future<void> LoadCodeCheck(code)async{
    
    //emit Loading
    emit(state.copyWith(newCodeCheckStatus: CodeCheckLoading()));


    DataState dataState = await authRepository.fetchCodeCheckData(code);

    if (dataState is DataSuccess) {

      //emit complete
      emit(state.copyWith(newCodeCheckStatus: CodeCheckCompleted(dataState.data)));
    } else if(dataState is DataFailed){
      
      //emit error
      emit(state.copyWith(newCodeCheckStatus: CodeCheckError(dataState.error!)));
    }
  }





}
