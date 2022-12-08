import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'profile_screen.dart';
import 'dart:convert';

class VideosScreen extends StatefulWidget {

  VideosScreen({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Videos'),
          centerTitle: false,
        ),
        body: Center(child: ListView(
          children: <Widget>[
            Text("do stuff here"),
            ],
          )
        ));
  }
}