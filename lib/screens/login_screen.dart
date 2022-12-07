import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Text('help me im trapped in a login screen',
          style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}