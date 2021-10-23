import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {


  final String message;
  final String userName;
  final String  userImage;
  final bool isMe;
  final Key key ;


  const MessageBubble(  this.message,  this.userName, this.userImage, this.isMe, this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment: isMe?MainAxisAlignment.start:MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe?const Color.fromRGBO(1, 169, 219, 1):const Color.fromRGBO(
                    4, 87, 111, 1.0),
                borderRadius: BorderRadius.only  (
                  topLeft: const Radius.circular(15),
                  topRight:const  Radius.circular(15),
                  bottomRight: isMe? const Radius.circular(15):const Radius.circular(0),
                  bottomLeft: !isMe? const Radius.circular(15):const Radius.circular(0),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              child: Column(
                crossAxisAlignment:isMe?CrossAxisAlignment.start:CrossAxisAlignment.end,
                children: [
                  Text(userName,style: TextStyle(color: isMe?Colors.black87:Colors.white),
                      textAlign: isMe?TextAlign.start:TextAlign.end),
                  Text(message,style: TextStyle(color: isMe?Colors.black87:Colors.white),
                      textAlign: isMe?TextAlign.start:TextAlign.end),

                ],
              ),
            ),
          ],
        ),
          Positioned(
           top: 0,
             left: isMe? 120:null,
             right: !isMe? 120:null,
             child: CircleAvatar(
               backgroundImage: NetworkImage(userImage),
             )),
      ],
    );
  }
}
