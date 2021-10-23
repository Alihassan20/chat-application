import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_00/screen/chat_page.dart';
import 'package:flutter_app_00/screen/sign_up.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _KeyForm = GlobalKey<FormState>();
   String _email = "";
   String _password = "";
  bool _isloding=false;


  final FirebaseAuth auth = FirebaseAuth.instance;

   _submit ()async{
    final validate = _KeyForm.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validate){
      _KeyForm.currentState!.save();
      try {
        setState(() {
          _isloding=true;
        });
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: _email.toLowerCase().trim(),
          password: _password.trim(),
        );
      } on FirebaseAuthException catch (e) {
        String message="Error";
        if (e.code == 'user-not-found') {
          message='No user found for that email.';
        } else if (e.code == 'wrong-password') {
     message='Wrong password provided for that user.';
        }
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        setState(() {
          _isloding=false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(40),topRight:Radius.circular(40) )),
        color:const Color.fromRGBO(1, 169, 219, 1),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: _KeyForm,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.none,
                  validator: (val) {
                    if (val!.isEmpty || !val.contains("@")) {
                      return "please enter a valid e-mail address";
                    } else {
                      return null;
                    }
                  },
                  key: const ValueKey("email"),
                  decoration: const InputDecoration(
                    label: Text("  E_mail"),
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                    hintText: "  enter e-mail",
                    icon: Icon(
                      Icons.email,
                      color: Colors.black87,
                    ),
                  ),
                  onSaved: (val) => setState(() {
                    _email=val!;
                  }),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty || val.length < 5) {
                      return "please enter at least 7 character";
                    } else {
                      return null;
                    }
                  },
                  key: const ValueKey("password"),
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black87,
                    ),
                    label: Text("  password"),
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                    hintText: "  enter password",
                  ),
                  onSaved: (val) => setState(() {
                    _password=val!;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
               const  SizedBox(
                  height: 10,
                ),
               const  SizedBox(
                  height: 20,
                ),
                if(_isloding)
                  const CircularProgressIndicator(),
                if(!_isloding)
                  RaisedButton(
                  onPressed: () async{
                   await  _submit();
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const ChatPage()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.black87,
                ),
                if(!_isloding)
                  FlatButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const SignUp()));
                }, child: const Text("  Create an Account  "),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
