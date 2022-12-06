import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameGeek',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'GameGeek Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          Padding(
            padding: EdgeInsets.only(bottom: 1);
          )
            ),
          ],
        ),
      ),
      drawer: HamburgerDir(),
    );
  }
}


class HamburgerDir extends StatelessWidget {

  // method for flutter data binding taken from: https://medium.com/flutter-community/data-binding-in-flutter-or-passing-data-from-a-child-widget-to-a-parent-widget-4b1c5ffe2114
  // final Callback onCorrectAdminLogin;
  // HamburgerDir({required this.onCorrectAdminLogin});

  //final adminDB = FirebaseFirestore.instance.collection('Admin');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text('Sleep Calculator',
                  style: Theme.of(context).textTheme.button
              ),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SplashScreen();
                        }));
              }),
        ],
      ),
    );
  }