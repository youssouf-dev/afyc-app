import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => new _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  String _post = "";

  Future<Null> _savePost(value) async {
  setState(() {
    _post = value;
  });

  return null;
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("New Post page"), 
        backgroundColor: Colors.deepOrange
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // new IconButton(icon: new Icon(Icons.home, color: Colors.deepOrange), iconSize: 70.0, onPressed: null),
              // new Text("New Post Page"),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new TextField(
                onChanged: (value) {_savePost(value);},
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: 'Please enter a post'
                  ),
                ),
              ),
              new RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  if(_post.length == 0) {
                    print("Post is empty");
                  } else {
                    //save the time
                    String _createdAt = new DateTime.now().toString();
                    //send the information
                    Firestore.instance
                      .collection('posts')
                      .document()
                      .setData({ 
                        'message': _post, 
                        'createdAt': _createdAt 
                      });

                    //return to the previous screen
                    Navigator.pop(context);

                    print("Post is: $_post");
                    print("Posted time: $_createdAt");
                  }
                },
                child: Text('Send'),
            ),
            ]
          )
        )
      ),

    );
  }
}
