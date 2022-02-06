import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String message = "";
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              onChanged: (val) {
                message = val;
              },
              decoration: const InputDecoration(
                hintText: 'Enter a message',
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                FirebaseFirestore.instance.collection('chat').add({
                  'text': message,
                  'createdAt': Timestamp.now(),
                  'userId': FirebaseAuth.instance.currentUser!.uid,
                });
                FocusScope.of(context).unfocus();
                messageController.text = "";
              },
              child: Text("Send"))
        ],
      ),
    );
  }
}
