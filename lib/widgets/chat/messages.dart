import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          itemCount: (snapshot.data! as QuerySnapshot).docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: MessageBubble(
                message: (snapshot.data! as QuerySnapshot).docs[index]["text"],
                isMe: (snapshot.data! as QuerySnapshot).docs[index]["userId"] ==
                    FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(
                  (snapshot.data! as QuerySnapshot).docs[index].reference.id,
                ),
                userId: (snapshot.data! as QuerySnapshot).docs[index]["userId"],
              ),
            );
          },
        );
      }),
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
