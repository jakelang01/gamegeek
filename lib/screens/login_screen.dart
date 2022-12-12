import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_geek/main.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  final userInfoDB = FirebaseFirestore.instance.collection('Users');
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";
  String password = "";
  String errorMessage = "";
  double errorMessageSize = 0.0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            // just some padding
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0)
            ),
            // headline for the login page
            Text(
              "Log in to Gamer App",
              style: Theme.of(context).textTheme.headline1,
            ),
            // horizontal rule
            Divider(
              height: 15,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).dividerColor,
            ),
            // username input box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: usernameController,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    labelText: 'Username',
                ),
              ),
            ),
            // password input box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: passwordController,
                style: Theme.of(context).textTheme.bodyText1,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  labelText: 'Password',
                ),
              ),
            ),
            // error message text
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: errorMessageSize),
            ),
            // login button
            ElevatedButton(
              child: const Text(
                "Login",
              ),
              onPressed: () async {
                String usernameCopy = usernameController.text;
                String passwordCopy = passwordController.text;
                if (!await passwordIsValid(usernameCopy, passwordCopy)) {
                  setErrorMessage("Username or Password is invalid!");
                }
                else {
                  setErrorMessage("");
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context){
                            return MyHomePage(title: 'Game Geek');
                          }));
                }
              },
            ),
            // new account button
            ElevatedButton(
              child: const Text(
                "Create New Account",
              ),
              onPressed: () {
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> usernameIsValid(String username) async {
    if (username.isEmpty) {
      return false;
    }
    // getting a document that doesn't exist returns an object with the "exists" property as false
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

    if (hashedPassword.toString() == databasePassword) {
      return true;
    }
    return false;
  }

  // if message is empty, then the error message text is hidden
  void setErrorMessage(String message) {
    if (message.isEmpty) {
      setState(() {
        errorMessage = "";
        errorMessageSize = 0.0;
      });
      return;
    }
    setState(() {
      errorMessage = message;
      errorMessageSize = 18.0;
    });
    return;
  }

  Future<void> createNewUser() async {
    return;
  }
}