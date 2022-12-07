import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {

  SettingsPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final adminDB = FirebaseFirestore.instance.collection('Admin');
  final messageDB = FirebaseFirestore.instance.collection('Admin');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
        ),
        body: Center(child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Light Mode'),
                    onPressed: () {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Dark Mode'),
                    onPressed: () {
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    },
                  ),
                ),
              ],
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