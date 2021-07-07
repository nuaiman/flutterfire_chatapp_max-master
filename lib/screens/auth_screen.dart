import 'package:flutter/material.dart';
import 'package:flutterfire_chatapp_max/screens/login_screen.dart';
import 'package:flutterfire_chatapp_max/screens/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLogin ? LoginScreen() : SignupScreen(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink,
        child: TextButton(
          child: Text(
            _isLogin ? 'Signup instead' : 'Login instead',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              _isLogin = !_isLogin;
            });
          },
        ),
      ),
    );
  }
}
