import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_00/screen/chat_page.dart';
import 'package:flutter_app_00/screen/splach.dart';
import 'package:flutter_app_00/screen/welcome.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: const Color.fromRGBO(215, 233, 247, 1)
      ),
      home:  StreamBuilder(builder: ( context,  snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
         return const SplashScreen();
        }
        if (snapshot.hasData){
         return const  ChatPage();
        }else{
          return const WelcomePage();
        }
      },stream: FirebaseAuth.instance.authStateChanges(),),
    );
  }
}



