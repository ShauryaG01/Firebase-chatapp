import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}


class _NewMessageState extends State<NewMessage> {
  var _enteredMssg = '';
  var _controller = new TextEditingController();

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    print(user.uid);
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMssg,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });
    // print(user.uid);
    _controller.clear();
    _enteredMssg = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message'),
              onChanged: (value) {
                _enteredMssg = value;
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).accentColor,
              onPressed: _enteredMssg.trim().isEmpty ? null : sendMessage)
        ],
      ),
    );
  }
}
