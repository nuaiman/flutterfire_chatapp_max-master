import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_chatapp_max/widgets/user_image_picker.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _userEmail = '';
  var _userName = '';
  var _userPass = '';

  final _formKey = GlobalKey<FormState>();

  File? _userImage;

  void pickedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() async {
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();

    if (_userImage == null) {
      return;
    }

    FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential userCredential;
    userCredential = await _auth.createUserWithEmailAndPassword(
        email: _userEmail.trim(), password: _userPass.trim());

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(_auth.currentUser!.uid + '.jpg');

    await ref.putFile(_userImage!).whenComplete(() {});

    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'username': _userName.trim(),
      'email': _userEmail.trim(),
      'imageUrl': url,
    });
  }

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
                  UserImagePicker(pickedImage),
                  SizedBox(
                    height: 20,
                  ),
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
                      _userName = val!;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.person,
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
                      onPressed: _trySubmit,
                      child: Text('Signup'),
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
