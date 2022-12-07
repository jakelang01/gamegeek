import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'profile_screen.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {

  SettingsPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: false,
        ),
        body: Center(child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: ElevatedButton(
                    child: Text('Light Mode'),
                    onPressed: () {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: ElevatedButton(
                    child: Text('Dark Mode'),
                    onPressed: () {
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 140,vertical: 5),
              child: ElevatedButton(
                child: Text('View Profile'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context){
                            return ProfilePage(key: Key('profile'),title: 'profile');
                          }));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 140),
              child: ElevatedButton(
                child: Text('Log Out'),
                onPressed: () {
                  print('no');
                },
              ),
            ),
          ],
        )
        ));
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}