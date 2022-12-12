import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  final userInfoDB = FirebaseFirestore.instance.collection('Users');
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          TextButton(
            child: Text("test button",
              style: Theme.of(context).textTheme.button
            ),
            onPressed: () async {

            }
          ),
        ],
      ),
    );
  }

  Future<bool> usernameIsValid(String username) async {
    // getting a document that doesnt exist returns an object with the "exists" property as false
    var userDocData = await userInfoDB.doc(username).get();
    if (userDocData.exists) {
      return true;
    }
    await userInfoDB.doc(username).delete();
    return false;
  }

  Future<bool> passwordIsValid(String username, String password) async {
    if (password.isEmpty || username.isEmpty || !await usernameIsValid(username)) {
      return false;
    }
    // salt password with username
    String saltedPassword = password + username;
    var passwordBytes = utf8.encode(saltedPassword);
    var hashedPassword = sha256.convert(passwordBytes);
    var userDocData = await userInfoDB.doc(username).get();
    var databasePassword = userDocData.get("password");
    //print(hashedPassword.toString());
    //print(databasePassword);

    if (hashedPassword.toString() == databasePassword) {
      return true;
    }
    return false;
  }

  Future<void> createNewUser() async {
    return;
  }
}