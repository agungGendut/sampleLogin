import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MainPage/MainHome/MainHomeScreen.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginData {
  String email = '';
  String password = '';
  String phone = '';
  String forgetpassword = '';
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool secureText = true, onSubmit = false, onProcess = false;
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '####-####-####-####', filter: {"#": RegExp(r'[0-9]')});
  int loginType = 0;
  final LoginData _data = LoginData();
  LoginBloc(): super(LoginUnitial()) {

    on<LoginEvent>((event, emit) async {
      await mapEventToStates(event, emit);
    });
  }

  Future<void> mapEventToStates(
      LoginEvent event, Emitter<LoginState> emit
      ) async {

    if (event is SetSecureText) {
      secureText = event.value;
      onSubmit = false;
    }

    if (event is SetEmailChange) {
      _data.email = event.value;
      onSubmit = false;
    }

    if (event is SetPasswordChange) {
      _data.password = event.value;
      onSubmit = false;
    }

    if (event is ResetFormLogin) {
      secureText = true;
      _data.email = "";
      _data.password = "";
      _data.phone = "";
      onSubmit = false;
      onProcess = false;
      maskFormatter.clear();
    }

    if (event is SubmitLogin) {
      onSubmit = true;

      if (_validateEmail() == null && _validatePassword() == null) {
        emit(LoginInitial(
            type: loginType,
            secureText: secureText,
            validateEmail: _validateEmail() ?? "",
            validatePassword: _validatePassword() ?? "",
            onProcess: true,
            validatePhone: _validatePhone() ?? "",
            maskFormatter: maskFormatter));
        if (event.statusLog == 200) {
          emit(SuccessLoginInitial("Login Success", "token", "tokenType"));
        } else {
          emit(ErrorLoginInitial("Check Email dan Password", "Login Error",));
        }
        onProcess = true;
      }
    }

    if (event is SetLoginType) {
      loginType = event.type;
    }

    emit(LoginInitial(
        type: loginType,
        maskFormatter: maskFormatter,
        secureText: secureText,
        validateEmail: _validateEmail() ?? "",
        validatePassword: _validatePassword() ?? "",
        onProcess: onProcess,
        validatePhone: _validatePhone() ?? ""));
  }

  String? _validateEmail() {
    if (_data.email.isNotEmpty) {
      try {
        bool isValid = EmailValidator.validate(_data.email);
        if (isValid == true){
          return '';
        } else {
          return 'Email address must match, example: example@example.com';
        }
      } catch (e) {
        return 'Email address must match, example: example@example.com';
      }
    } else {
      if (onSubmit) {
        return 'Alamat email harus diisi';
      }
    }

    return null;
  }

  String? _validatePhone() {
    if (_data.phone != "") {
      if (_data.phone.length < 4) {
        return 'Nomor Handphone salah';
      }
    } else {
      if (onSubmit) {
        return 'Nomor Handphone harus diisi';
      }
    }
    return null;
  }

  String? _validatePassword() {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
    String pattern1 = r'^(?=.*?[A-Z])(?=.*?[0-9])';
    if (_data.password != "") {
      RegExp regExp = RegExp(pattern);
      RegExp regExp1 = RegExp(pattern1);
      if (_data.password.length < 8) {
        return 'Password harus lebih 8 karakter.';
      } else if (!regExp.hasMatch(_data.password)) {
        return 'Password harus kombinasi huruf dan angka';
      } else if (!regExp1.hasMatch(_data.password)){
        return 'Password harus kombinasi huruf besar dan kecil';
      }
    } else {
      if (onSubmit) {
        return 'Password harus diisi';
      }
    }
    return null;
  }
}
