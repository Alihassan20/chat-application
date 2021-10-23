import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_00/widgets/sign_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  @override

  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  SignUpForm(),
    );
  }
}
