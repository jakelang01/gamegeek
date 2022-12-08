import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:game_geek/screens/advanced_search_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {

  List<List<String>>? rawData;
  String dataFilePath = 'assets/bgg_db_2018_01.csv';
  String exampleText = '';
  String nameText = '';
  String minPlayerText = '';
  TextEditingController nameInput = TextEditingController();
  TextEditingController minPlayerInput = TextEditingController();
  TextEditingController maxPlayerInput = TextEditingController();
  TextEditingController avgTimeInput = TextEditingController();

  // UI ideas:
  //  - First screen that has buttons asking what you want to filter by (game info, filter options, etc.) then
  //    take them to another screen to search by that criteria
  //  - Text field at top to enter game name
  //  - Top right have a filter button that drops down and can select num. players (low-high, high-low) and
  //    game duration (low-high, high-low), etc.
  //  -

  //  - difficult search filter; multiple text boxes that control different search criteria then have button to
  //    search and filter for game with those options
  //    https://www.addsearch.com/blog/how-to-build-a-great-search-ui/


  // function to search for game and get information
  // text field to enter game name then search csv/database for all the information


  // function to filter game search by number of players and see related game information
  // text field to enter number of players and have if statement to search through database?

  // function to sort by the duration of a game (lowest-highest, vice-versa)
  // ?


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
                  child:ElevatedButton(
                    child: Text('Advanced Search'),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return AdvancedSearchScreen(title: 'Advanced Search', key: const Key("advanced search"));
                              }));
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

/*
class GameInfoData {
  List<List<String>>? rawData;
  String dataFilePath = 'assets/bgg_db_2018_01.csv';

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
}
 */