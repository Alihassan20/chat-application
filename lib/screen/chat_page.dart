import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_00/widgets/chat_form.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("CHAT"),
          centerTitle: true,
          actions: [
            DropdownButton(
              underline: Container(),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: const [
                      Text("Log out"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.black87,
                      )
                    ],
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (iden) {
                if (iden == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45)),
          ),
          backgroundColor: const Color.fromRGBO(1, 169, 219, 1)),
      body: const ChatForm(),
    );
  }
}
