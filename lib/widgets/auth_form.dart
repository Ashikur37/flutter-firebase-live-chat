import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);
  final Function onSubmit;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _username = "";
  String _password = "";
  void _trySubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      widget.onSubmit(_email, _password, _username, true);
    }
  }

  void _trySignup() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      widget.onSubmit(_email, _password, _username, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey("email"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _email = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    key: const ValueKey("username"),
                    decoration: const InputDecoration(labelText: 'Username'),
                    onChanged: (val) {
                      _username = val;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    onChanged: (val) {
                      _password = val;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pinkAccent),
                    ),
                    child: const Text("login"),
                  ),
                  TextButton(
                    onPressed: _trySignup,
                    child: const Text("Signup"),
                  ),
                ],
              )),
        ),
      ),
    ));
  }
}
