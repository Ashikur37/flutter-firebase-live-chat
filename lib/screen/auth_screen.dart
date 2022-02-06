import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitForm(
      String email, String password, String username, bool isLogin) async {
    if (isLogin) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } catch (error) {
        var snackBar = SnackBar(
          content: Text(
            error.toString(),
          ),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      try {
        var result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      } catch (error) {
        var snackBar = SnackBar(
          content: Text(
            error.toString(),
          ),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff168794),
      body: AuthForm(onSubmit: _submitForm),
    );
  }
}
