import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class AdvancedSearchScreen extends StatefulWidget {

  AdvancedSearchScreen({required Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AdvancedSearchScreen createState() => _AdvancedSearchScreen();
}

class _AdvancedSearchScreen extends State<AdvancedSearchScreen> {

  List<List<String>>? rawData;
  String dataFilePath = 'assets/bgg_db_2018_01.csv';
  String exampleText = '';
  String nameText = '';
  String minPlayerText = '';
  TextEditingController nameInput = TextEditingController();
  TextEditingController minPlayerInput = TextEditingController();
  TextEditingController maxPlayerInput = TextEditingController();
  TextEditingController avgTimeInput = TextEditingController();

  Future<void> readDataFile() async {
    var bytes = await rootBundle.load(dataFilePath);
    String bytesAsString = utf8.decode(bytes.buffer.asUint8List());
    rawData = const CsvToListConverter().convert(bytesAsString);
  }

  List<String> getRow(int rowNum) {
    return rawData![rowNum];
  }

  String getEntry(int rowNum, int colNum) {
    return getRow(rowNum)[colNum];
  }

  String getName(int rowNum, int colNum) {
    return getEntry(rowNum, colNum);
  }

  void setData(int rowNum, int colNum) {
    String name = getEntry(rowNum, colNum);
    String rank = '';
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game Geek Search'),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 210, top: 10, bottom: 10),
                child: TextFormField(
                  controller: nameInput,
                  decoration: InputDecoration(
                    hintText: 'Game Name',
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 210, right: 10, top: 10, bottom: 10),
                child: TextFormField(
                  controller: minPlayerInput,
                  decoration: InputDecoration(
                    hintText: 'Mininum Number of Players',
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      nameText = nameInput.text;
                      minPlayerText = minPlayerInput.text;
                      setData(1, 1);
                    },
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  "im playing " + exampleText,
                  textAlign: TextAlign.center,
                  //overflow: TextOverflow.ellipsis,
                  textScaleFactor: 0.9,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ]
        )
    );
  }
}