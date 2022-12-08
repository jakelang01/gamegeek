import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class VideoResultScreen extends StatefulWidget {

  VideoResultScreen({required Key? key, required this.title, required List docs}) : super(key: key);
  final String title;

  @override
  _VideoResultScreenState createState() => _VideoResultScreenState();
}

class _VideoResultScreenState extends State<VideoResultScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Videos'),
          centerTitle: false,
        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10),
                child: Center(child: Text("show videos here", style: Theme.of(context).textTheme.headline1,))
            ),
          ],
        )
    );
  }
}