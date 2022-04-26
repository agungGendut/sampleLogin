import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String tittle;

  LoginButton({Key? key, required VoidCallback onPressed, required this.tittle})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      onPressed: _onPressed,
      child: Text(tittle, style: GoogleFonts.lato(color: Colors.white),),
    );
  }
}