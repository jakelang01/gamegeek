import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:game_geek/screens/alarms_screen.dart';
import 'package:game_geek/screens/login_screen.dart';
import 'package:game_geek/screens/game_search_screen.dart';
import 'package:game_geek/screens/settings_screen.dart';
import 'package:game_geek/screens/videos_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {

  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode newMode) {
    setState(() {
      _themeMode = newMode;
    });
  }

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
                    primarySwatch: Colors.brown,
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.brown,
                  ),
                  scaffoldBackgroundColor: Colors.grey.shade900,
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 18
                        ),
                    ),
                ),
                themeMode: _themeMode,
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
                }));
              },
          ),
          ListTile(
              title: Text('Game Screen',
                style: Theme.of(context).textTheme.button,
              ),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context){
                          return SearchScreen();
                        }));
              },
          ),
          ListTile(
            title: Text('Videos',
              style: Theme.of(context).textTheme.button,
            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context){
                        return VideosScreen(key:Key('videos'),title: 'videos',);
                      }));
            },
          ),
          ListTile(
            title: Text('Settings',
                style: Theme
                    .of(context)
                    .textTheme
                    .button
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SettingsScreen(title: 'settings', key: Key("settings"));
                      }));
            },
          ),
        ],
      ),
    );
  }
}