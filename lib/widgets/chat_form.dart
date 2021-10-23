import 'package:flutter/material.dart';
import 'package:flutter_app_00/widgets/chat/message.dart';
import 'package:flutter_app_00/widgets/chat/new_message.dart';
class ChatForm extends StatefulWidget {
  const ChatForm({Key? key}) : super(key: key);

  @override
  _ChatFormState createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child:Column(
        children:const [
           Expanded(child: Message()),
          NewMessage(),
        ],
      ) ,
    );
  }
}
