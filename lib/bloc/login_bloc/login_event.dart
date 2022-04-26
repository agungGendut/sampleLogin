part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SetSecureText extends LoginEvent {
  final bool value;
  SetSecureText(this.value);
}

class SetEmailChange extends LoginEvent {
  final String value;
  SetEmailChange(this.value);
}

class SetPhoneChange extends LoginEvent {
  final String value;
  SetPhoneChange(this.value);
}

class SetPasswordChange extends LoginEvent {
  final String value;
  SetPasswordChange(this.value);
}

class ResetFormLogin extends LoginEvent {}

class SubmitLogin extends LoginEvent {
  final BuildContext context;
  final int statusLog;
  SubmitLogin(this.context, this.statusLog);
}

class SetLoginType extends LoginEvent {
  final int type;
  SetLoginType(this.type);
}
