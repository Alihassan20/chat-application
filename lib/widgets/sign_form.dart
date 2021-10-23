import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_00/screen/chat_page.dart';
import 'package:flutter_app_00/screen/login.dart';
import 'package:flutter_app_00/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' ;


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _KeyForm = GlobalKey<FormState>();
   String _email = "";
  String _userName = "";
  String _password = "";
   String _confirmPass = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
   bool _isloding =false;
    File? _userImageFile;
  late UserCredential userCredential;


  void _pickedImage(File pickedImage){
     _userImageFile=pickedImage;
   }

   _submit () async{
    final validate = _KeyForm.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile ==null){
      Scaffold.of(context).showSnackBar(const SnackBar(content: Text("please pick image")));
      return;
    }
    if (validate) {
      _KeyForm.currentState!.save();

      try {
        setState(() {
          _isloding=true;
        });

         userCredential = await auth
            .createUserWithEmailAndPassword(
            email: _email.toLowerCase().trim(), password: _password.trim());


        final ref = FirebaseStorage.instance.ref().child('userImage').child(userCredential.user!.uid+'ipg');

        await ref.putFile(_userImageFile!);

        String url=await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
          'email':_email,
          'username':_userName,
          'password':_password,
          'image_url':url,
        }
        );
      }on FirebaseAuthException catch (e) {
        String message="Error";
        if (e.code == 'weak-password') {
          message='The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message='The account already exists for that email.';
        }
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        setState(() {
          _isloding=false;
        });
      }catch (e) {
        setState(() {
          _isloding=false;
        });
        print(e);
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
                UserImagePicker(_pickedImage),
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
                  onSaved: (val)=>setState(() {
                    _email=val!;
                  }),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter a valid Username";
                    } else {
                      return null;
                    }
                  },
                  key: const ValueKey("Username"),
                  decoration: const InputDecoration(
                    label: Text("  Username"),
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                    hintText: "  enter your Username",
                    icon: Icon(
                      Icons.person,
                      color: Colors.black87,
                    ),
                  ),
                  onSaved: (val)=>setState(() {
                    _userName=val!;
                  }),
                  keyboardType: TextInputType.name,
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
                    _password = val!;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const  SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty || _password != _confirmPass) {
                      return "please enter match password";
                    } else {
                      return null;
                    }
                  },
                  key: const ValueKey("confirm"),
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black87,
                    ),
                    label: Text("  confirm password"),
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                    hintText: "  enter confirm password",
                  ),
                  onSaved: (val) => setState(() {
                    _confirmPass = val!;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const  SizedBox(
                  height: 20,
                ),
                if(_isloding)
                  const CircularProgressIndicator(),
                if(!_isloding)
                  RaisedButton(
                  onPressed: () async{
                     await _submit();
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const ChatPage()));

                  },
                  child: const Text(
                    "Sign Up",
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginPage()));
                }, child: const Text("  I have an Account  "),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
