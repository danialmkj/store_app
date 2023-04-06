import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../common/params/sign_up_params.dart';
import '../../../data/models/sign_up_model.dart';

part 'signup_data_status.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit() : super(SignupState(signUpDataStatus: SignUpDataLoading()));
}
