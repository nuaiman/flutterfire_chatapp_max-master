import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _userEmail = '';
  var _userPass = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (val) {
                      _userEmail = val!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (val) {
                      _userPass = val!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState!.save();
                        FocusScope.of(context).unfocus();

                        FirebaseAuth _auth = FirebaseAuth.instance;
                        UserCredential userCredential;

                        userCredential = await _auth.signInWithEmailAndPassword(
                            email: _userEmail.trim(),
                            password: _userPass.trim());
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
