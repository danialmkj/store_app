part of 'sign_up_cubit.dart';

class SignupState {
  SignUpDataStatus signUpDataStatus;

  SignupState({
    required this.signUpDataStatus,
  });

  SignupState copyWith({
    SignUpDataStatus? newSignUpDataStatus,
  }){
    return SignupState(
      signUpDataStatus: newSignUpDataStatus ?? signUpDataStatus,
    );
  }
}