import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/features/feature_auth/repository/auth_repository.dart';

import '../../../../../common/params/sign_up_params.dart';
import '../../../data/models/login_with_sms_model.dart';
import '../../../data/models/sign_up_model.dart';

part 'signup_data_status.dart';
part 'sign_up_state.dart';
part 'call_code_status.dart';

class SignUpCubit extends Cubit<SignupState> {
  AuthRepository authRepository;

  SignUpCubit(this.authRepository)
      : super(SignupState(
            signUpDataStatus: SignUpDataLoading(),
            callCodeStatus: CallCodeLoading()));



 //write methods   

}
