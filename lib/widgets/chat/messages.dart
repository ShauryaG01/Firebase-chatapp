import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/widgets/chat/mesage_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.docs;
        final user = FirebaseAuth.instance.currentUser.uid;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, item) => MessageBubble(
            chatDocs[item]['text'],
            chatDocs[item]['userId'] == user,
          ),
        );
      },
    );
  }
}
