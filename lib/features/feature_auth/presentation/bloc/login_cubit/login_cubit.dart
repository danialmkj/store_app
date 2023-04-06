import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/login_with_sms_model.dart';

part 'login_state.dart';
part 'login_data_status.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
}
