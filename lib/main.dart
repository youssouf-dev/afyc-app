// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'new_post.dart';
import 'post_detail.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Home Page'),
      routes: <String, WidgetBuilder> {
       "/newPostPage": (BuildContext context) => new NewPostPage(),
       "/postDetailPage": (BuildContext context) => new PostDetailPage("fff"),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new PostList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {Navigator.of(context).pushNamed("/newPostPage");},
        tooltip: 'New Post',
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
                      return new PostDetailPage(document.documentID);
                      }
                    )
                );
                print(document.documentID);
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