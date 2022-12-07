import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:game_geek/screens/alarms_screen.dart';
import 'package:game_geek/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            print("couldnt connect");
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                title: 'Game Geek',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.blue,
                  ),
                ),
                home: const MyHomePage(title: 'Game Geek')
            );
          }
          Widget loading = MaterialApp();
          return loading;
        }
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      drawer: HamburgerDir(),
    );
  }
}

class HamburgerDir extends StatelessWidget {

  // method for flutter data binding taken from: https://medium.com/flutter-community/data-binding-in-flutter-or-passing-data-from-a-child-widget-to-a-parent-widget-4b1c5ffe2114

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Example button',
                style: Theme
                    .of(context)
                    .textTheme
                    .button
            ),
            onTap: (){
              print("tapped!");
            },
          ),
          ListTile(
            title: Text('Game Alarm',
              style: Theme.of(context).textTheme.button,
            ),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context){
                      return AlarmScreen();
                    }));
            }
          ),
          ListTile(
            title: Text('Login Screen',
              style: Theme.of(context).textTheme.button,
          ),
          onTap:(){
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context){
                  return LoginScreen();
                }));}
          ),
        ],
      ),
    );
  }
}