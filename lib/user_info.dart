import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => new _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {

  String _myUsername = "";
  String _newName = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
    // final prefs = SharedPreferences.getInstance();
    // prefs.setInt('counter', 2);

    // _counter = _prefs.then((SharedPreferences prefs) {
    //   return (prefs.getInt('counter') ?? 0);
    // });

    // Firestore.instance
    // .collection('posts')
    // .where("topic", isEqualTo: "flutter")
    // .snapshots()
    // .listen((data) =>
    //     data.documents.forEach((doc) => print(doc["title"])));
  }

  //Loading the current username on start
  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _myUsername = (prefs.getString('username') ?? "+_+");
    });
  }

  Future<Null> _saveName(value) async {
  setState(() {
    _newName = value;
  });

  return null;
}

// Updating username after click
  _updateUsername() async {

    if (_newName == "") {
      print('No Name entered!!!');
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString('username', _newName);
      });
      //return to the previous screen
      Navigator.pop(context);
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("User Information"), 
        backgroundColor: Colors.deepPurple
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.account_circle, color: Colors.deepPurple), iconSize: 70.0, onPressed: null),
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Text("You need a username before you can post something!", textAlign: TextAlign.center,),
              ),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Text("Current username: ", textAlign: TextAlign.center,),
              ),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Text(_myUsername, textAlign: TextAlign.center,),
              ),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new TextField(
                onChanged: (value) {_saveName(value);},
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: 'Please enter a username'
                  ),
                ),
              ),
              new RaisedButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: _updateUsername,
                child: Text('Save'),
            ),
            ]
          )
        )
      ),

    );
  }
}
