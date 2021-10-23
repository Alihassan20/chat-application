import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_00/screen/login.dart';
import 'package:flutter_app_00/screen/sign_up.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  var islogin=true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 90),
            child: Image.asset("Images/welcome.png"),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildRaisedButton("Sign Up",!islogin),
              buildRaisedButton("Login",islogin),
            ],
          )
        ],
      ),
    );
  }

  RaisedButton buildRaisedButton(String txt, islogin) {
    return RaisedButton(
              padding: const EdgeInsets.all(15),
              onPressed: () {
                islogin? Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginPage(),)):
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUp(),));
              },
              child:  Text(
                txt,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color:  const Color.fromRGBO(1, 169, 219, 1),
            );
  }
}
