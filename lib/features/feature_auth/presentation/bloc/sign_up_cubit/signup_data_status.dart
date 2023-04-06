part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpDataStatus {}

class SignUpDataInitial extends SignUpDataStatus {}

class SignUpDataLoading extends SignUpDataStatus {}

class SignUpCompleted extends SignUpDataStatus {
  final SignupModel signupModel;
  SignUpCompleted(this.signupModel);
}

class SignUpDataError extends SignUpDataStatus {
  final String errorMessage;
  SignUpDataError(this.errorMessage);
}


// it was for sign up event 
class LoadSignUp extends SignUpDataStatus {
   final SingUpParams signUpParams;

  LoadSignUp(this.signUpParams);
}

class LoadRegisterCodeCheck extends SignUpDataStatus {
  final String mobile;
  LoadRegisterCodeCheck(this.mobile);
}
