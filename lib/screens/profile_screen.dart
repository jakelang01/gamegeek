import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // example fields that could be in a profile
  // need to be in user's database document
  //TODO: Get data for logged in user from db on build
  //TODO: Update relevant field on button press
  Map<String,String> userData = {"name":"","birthday":"","location":"","favorite":""};
  final userDB = FirebaseFirestore.instance.collection('Users');
  String username = "exampleUsername"; // change these to reflect logged in user
  String password = "password";
  
  Future<void> getData() async {
    QuerySnapshot<Map<String,dynamic>> userQuery = await userDB.where("username",isEqualTo: username).where("password",isEqualTo: password).get();
    QueryDocumentSnapshot userDoc = userQuery.docs.elementAt(0);
    setState(() {
      userData["name"] = userDoc.get("name");
      userData["birthday"] = userDoc.get("birthday");
      userData["location"] = userDoc.get("location");
      userData["favorite"] = userDoc.get("favorite");
    });
  }

  void initState() {
    getData();
  }

  Widget createProfileRow(String display, String field) {
    return Padding(padding: EdgeInsets.all(10),
        child: Row(
            children: <Widget>[
              Text(display,style: Theme.of(context).textTheme.bodyText1,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child:ElevatedButton(
                  child: Text('Edit',),
                  onPressed: (){
                    editBox(context, field);
                    },
                ),
              ),
            ]
        )
    );
  }

  Future<void> editBox(BuildContext context, String field) async {
    TextEditingController controller = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change $field:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New $field',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                editField(field, controller.value.text);
              }
            ),
          ],
        );
      },
    );
  }

  void editField(String field, String newValue) {
    userDB.doc(username).update({field:newValue});
    setState(() {
      userData[field] = newValue;
    });
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
            createProfileRow("Name: " + (userData["name"] as String), "name"),
            createProfileRow("Birthday: " + (userData["birthday"] as String),"birthday"),
            createProfileRow("Location: " + (userData["location"] as String),"location"),
            createProfileRow("Favorite Game: " + (userData["favorite"] as String),"favorite"),
          ],
        )
        ));
  }
}