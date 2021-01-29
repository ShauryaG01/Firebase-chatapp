import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User loggedinuser;

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}


class _NewMessageState extends State<NewMessage> {
  var _enteredMssg = '';
  var _controller = new TextEditingController();

  void sendMessage() async {
    if(loggedinuser!=null)
      {
        if(_enteredMssg == '')return;
        FocusScope.of(context).unfocus();
        FirebaseFirestore.instance.collection('chat').add({
          'text': _enteredMssg,
          'createdAt': Timestamp.now(),
          'userId': loggedinuser.uid,
        });
        // print(user.uid);
        _controller.clear();
        _enteredMssg = '';

      }

  }
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    getdata();

    super.initState();
  }
  void getdata() async {
    try{
      final user = await _auth.currentUser;
      if(user!=null)
      {
        loggedinuser = user;
        print(loggedinuser.email);
      }
    }catch(e)
    {
      print(e);
    }
  }
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
              onPressed:  sendMessage)
        ],
      ),
    );
  }
}
