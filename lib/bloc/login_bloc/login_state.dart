part of 'login_bloc.dart';

@immutable
class LoginState {}

class LoginUnitial extends LoginState {}

class LoginInitial extends LoginState {
  final bool secureText, onProcess;
  final String validateEmail, validatePassword, validatePhone;
  final MaskTextInputFormatter maskFormatter;
  final int type;
  LoginInitial(
      {required this.secureText,
        required this.type,
        required this.validateEmail,
        required this.validatePassword,
        required this.validatePhone,
        required this.onProcess,
        required this.maskFormatter});
}

class LoginUnAuthInitial extends LoginState {
  final bool secureText, onProcess;
  final String validateEmail, validatePassword, validatePhone;
  final MaskTextInputFormatter maskFormatter;
  final int type;
  LoginUnAuthInitial(
      {required this.secureText,
        required this.type,
        required this.validateEmail,
        required this.validatePassword,
        required this.validatePhone,
        required this.onProcess,
        required this.maskFormatter});
}

class ErrorLoginInitial extends LoginState {
  final String message;
  final String errors;
  ErrorLoginInitial(this.message, this.errors);
}

class SuccessLoginInitial extends LoginState {
  final String auth;
  final String token, tokenType;
  SuccessLoginInitial(this.auth, this.token, this.tokenType);
}
