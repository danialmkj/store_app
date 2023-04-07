// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState {
  final LoginDataStatus loginDataStatus;
  final CodeCheckStatus codeCheckStatus;
  
  LoginState({
    required this.loginDataStatus,
    required this.codeCheckStatus,
  });


  LoginState copyWith({
    LoginDataStatus? newLoginDataStatus,
    CodeCheckStatus? newCodeCheckStatus,
  }) {
    return LoginState(
      loginDataStatus: newLoginDataStatus ?? loginDataStatus,
      codeCheckStatus: newCodeCheckStatus ?? codeCheckStatus,
    );
  }
}

