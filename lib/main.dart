import 'dart:async';
import 'new_post.dart';
import 'post_detail.dart';
import 'user_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Afyc Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: new MyHomePage(title: 'Home Page'),
      home: new MyHomePage(title: 'Home Page') ,
      routes: <String, WidgetBuilder> {
       "/newPostPage": (BuildContext context) => new NewPostPage(),
      //  "/postDetailPage": (BuildContext context) => new PostDetailPage("fff"),
       "/userInfoPage": (BuildContext context) => new UserInfoPage(),
     },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Future<int> _counter;
  // Future<String> _username;
  
  // int _counter = 0;
  String _myUsername = "_";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  //Loading the current username  on start
  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _myUsername = (prefs.getString('username') ?? "+_+");
    });
  }

  //Incrementing counter after click
  // _incrementCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _counter = (prefs.getInt('counter') ?? 0) + 1;
  //     prefs.setInt('counter', _counter);
  //   });
  // }

  _goToNewPostPage() async {

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_myUsername == "_" || _myUsername == "+_+"){
      Navigator.of(context).pushNamed("/userInfoPage");
    } else {
      Navigator.of(context).pushNamed("/newPostPage");
    }

    
    // final SharedPreferences prefs = await _prefs;
    // final int counter = (prefs.getInt('counter') ?? 0) + 1;

    // prefs.setInt('counter', counter);

    // setState(() {
    //   _counter = prefs.setInt("counter", counter).then((bool success) {
    //     return counter;
    //   });
    // });
  }

  

  @override
  Widget build(BuildContext context) {
    // _loadUsername();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        // title: new Text(_myUsername),
        actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {Navigator.of(context).pushNamed("/userInfoPage");},
              // onPressed: _insert,
              tooltip: 'Checkout your profile',
            ),
          ],
      ),
      body: new PostList(),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_myUsername',
      //         style: Theme.of(context).textTheme.display1,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: new FloatingActionButton(
        // onPressed: () {Navigator.of(context).pushNamed("/newPostPage");},
        onPressed: _goToNewPostPage,
        // tooltip: 'New Post',
        // tooltip: ,
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) {
                      return new PostDetailPage(document);
                      }
                    )
                );
                // print(document.documentID);
                },
              onLongPress: () {print("wanna delete?");},
              title: new Text(document['message']),
              subtitle: new Text(document['createdAt']),
            );
          }).toList(),
        );
      },
    );
  }
}