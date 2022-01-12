import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: ((context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (ctx, index) => Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      (snapshot.data! as QuerySnapshot).docs[index]["text"]),
                ),
              )),
        stream: FirebaseFirestore.instance
            .collection('chats/iUpUhT6LePWHskZcQu7j/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/iUpUhT6LePWHskZcQu7j/messages')
              .add({'text': 'Hello World'});
        },
      ),
    );
  }
}
