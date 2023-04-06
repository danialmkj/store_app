part of 'sign_up_cubit.dart';


@immutable
abstract class CallCodeStatus {}

class CallCodeInitial extends CallCodeStatus {}

class CallCodeLoading extends CallCodeStatus {}

class CallCodeCompleted extends CallCodeStatus {
  final LoginWithSmsModel loginWithSmsModel;
  CallCodeCompleted(this.loginWithSmsModel);
}

class CallCodeError extends CallCodeStatus {
  final String errorMessage;
  CallCodeError(this.errorMessage);
}