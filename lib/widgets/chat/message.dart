
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_00/widgets/chat/message_bubbles.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot> (
        stream:FirebaseFirestore.instance.collection('chat').orderBy('time',descending: true).snapshots() ,
        builder: (ctx,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
         final docs=snapshot.data!.docs;

      final  user =   FirebaseAuth.instance.currentUser;
      final uid = user!.uid;

      return ListView.builder(itemCount:docs.length,reverse: true ,itemBuilder:(context,index)=>
      MessageBubble(
        docs[index]['text'],
        docs[index]['username'],
        docs[index]['userImage'],
        docs[index]['userId']==uid,
         ValueKey(docs[index].id),

      )
      );
    });
  }
}
