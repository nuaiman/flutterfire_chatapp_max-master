import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMsg = '';
  var msgCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: msgCon,
              onChanged: (val) {
                setState(() {
                  _enteredMsg = val;
                });
              },
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: _enteredMsg.trim().isEmpty
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    var userdata = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_auth.currentUser!.uid)
                        .get();
                    FirebaseFirestore.instance.collection('chat').doc().set({
                      'text': _enteredMsg,
                      'createdAt': Timestamp.now(),
                      'userId': _auth.currentUser!.uid,
                      'username': userdata['username'],
                      'userImage': userdata['imageUrl'],
                    });
                    msgCon.clear();
                    setState(() {
                      _enteredMsg = '';
                    });
                  },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
