import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {

  ProfilePage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // example fields that could be in a profile
  // need to be in user's database document
  //TODO: Get data from db on build
  //TODO: Update relevant field on button press
  String name = "";
  String age = "";
  String location = "";
  String favorite = "";

  Widget createProfileRow(String display, String field) {
    return Padding(padding: EdgeInsets.all(10),
        child: Row(
            children: <Widget>[
              Text(display),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child:ElevatedButton(
                  child: Text('Edit'),
                  onPressed: (){
                    editField(field);
                    },
                ),
              ),
            ]
        )
    );
  }

  void editField(String field) {
    print(field);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: false,
        ),
        body: Center(child: ListView(
          children: <Widget>[
            createProfileRow("Name: " + name, "Name"),
            createProfileRow("Age: " + age,"Age"),
            createProfileRow("Location: " + location,"Location"),
            createProfileRow("Favorite Game: " + favorite,"Favorite"),
          ],
        )
        ));
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}