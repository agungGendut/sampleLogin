import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../utils/LoadingPage.dart';
import '../../MainHome/MainHomeScreen.dart';
import 'Login_button.dart';

class LoginForm extends StatefulWidget {
  final FocusNode emailFocused;
  final FocusNode passwordFocused;

  LoginForm({Key? key, required this.emailFocused, required this.passwordFocused}): super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _secureText = true;
  String langugeSelected = '';

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(ResetFormLogin());
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (context, state) {
        if (state is ErrorLoginInitial) {
          Fluttertoast.showToast(
              msg: state.errors,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red
          );
        }

        if (state is SuccessLoginInitial) {
          Fluttertoast.showToast(
              msg: state.auth,
              backgroundColor: Colors.red
          );

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')
              ), (route) => true);
        }
      },
      builder: (context, state){
        if (state is LoginInitial){
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always, controller: _emailController,
                    focusNode: widget.emailFocused,
                    style: GoogleFonts.lato(fontSize: 14, color: Colors.white),
                    decoration: InputDecoration(
                      icon: const Icon(FontAwesomeIcons.envelope, color: Colors.white,),
                      errorText: state.validateEmail,
                      errorMaxLines: 2,
                      labelText: 'Email',
                      labelStyle: GoogleFonts.lato(fontSize: 17.0, color: Colors.white),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    onChanged: (value) => context
                        .read<LoginBloc>()
                        .add(SetEmailChange(value)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always, controller: _passwordController,
                    focusNode: widget.passwordFocused,
                    style: GoogleFonts.lato(fontSize: 14, color: Colors.white),
                    decoration: InputDecoration(
                      icon: const Icon(FontAwesomeIcons.key, color: Colors.white,),
                      suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      labelText: 'Password',
                      labelStyle: GoogleFonts.lato(fontSize: 17.0, color: Colors.white),
                      errorText: state.validatePassword,
                      errorMaxLines: 2,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    obscureText: _secureText,
                    autocorrect: false,
                    onChanged: (value) => context
                        .read<LoginBloc>()
                        .add(SetPasswordChange(value)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LoginButton(
                            tittle: 'Submit',
                            onPressed: (){
                              if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                                return _onFormSubmitted(context);
                              } else {
                                return;
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return LoadingPage();
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    context.read<LoginBloc>().add(
      SetEmailChange(_emailController.text),
    );
  }

  void _onPasswordChanged() {
    context.read<LoginBloc>().add(
      SetPasswordChange(_passwordController.text),
    );
  }

  void _onFormSubmitted(BuildContext context) {
    context.read<LoginBloc>().add(
      SubmitLogin(context, 200),
    );
  }
}