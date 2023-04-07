import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_auth/repository/auth_repository.dart';

import '../../../../../common/params/sign_up_params.dart';
import '../../../data/models/login_with_sms_model.dart';
import '../../../data/models/sign_up_model.dart';

part 'signup_data_status.dart';
part 'call_code_status.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignupState> {
  AuthRepository authRepository;

  SignUpCubit(this.authRepository)
      : super(SignupState(
            signUpDataStatus: SignUpDataLoading(),
            callCodeStatus: CallCodeInitial()));

  
  //method load sign up
  Future<void> loadSignUp(SingUpParams singUpParams) async {

    //emit Loading
    emit(state.copyWith(newSignUpDataStatus: SignUpDataLoading()));
    
    DataState dataState = await authRepository.fetchSingUpData(singUpParams);

    if (dataState is DataSuccess) {

      //emit complete
      emit(state.copyWith(newSignUpDataStatus: SignUpCompleted(dataState.data)));
    } else if(dataState is DataFailed) {
      
      //emit error
      emit(state.copyWith(newSignUpDataStatus: SignUpDataError(dataState.error!)));
    }

  }


 // method load register code check
  Future<void> LoadRegisterCodeCheck(code) async{

    // emit loading
    emit(state.copyWith(newCallCodeStatus: CallCodeLoading()));

  
    DataState dataState = await authRepository.fetchRegisterCodeCheckData(code);


    if (dataState is DataSuccess) {
      
      // emit complete 
      emit(state.copyWith(newCallCodeStatus: CallCodeCompleted(dataState.data)));
    
    } else if(dataState is DataFailed ){

    // emit error
    emit(state.copyWith(newCallCodeStatus: CallCodeError(dataState.error!)));

    }
  }

}
