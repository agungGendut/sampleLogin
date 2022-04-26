import 'package:flutter/material.dart';
import 'component/Login_form.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 0.8,
          width: MediaQuery.of(context).size.width / 1,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1,
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: Image.asset("assets/coreapps1.png", scale: 1,),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 2.7,
                  left: MediaQuery.of(context).size.width / 50,
                  right: MediaQuery.of(context).size.width / 50,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: const BoxDecoration(
                        color: Color(0x0FFFF0122),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0))
                    ),
                  )
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.4,
                left: MediaQuery.of(context).size.width / 50,
                right: MediaQuery.of(context).size.width / 50,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0))
                  ),
                  child: LoginForm(
                    emailFocused: _emailFocusNode,
                    passwordFocused: _passwordFocusNode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}