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
  String rank = '';
  String URL = '';
  String gameID = '';
  String gameName = '';
  String minPlayers = '';
  String maxPlayers = '';
  String avgTime = '';
  String minTime = '';
  String maxTime = '';
  String year = '';
  String restOfString = '';
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

  int getName(String name) {
    for(int i=1; i<5000; i++) {
      if(name.toLowerCase() == getEntry(i, 3).toLowerCase()) {
        return i; // i is the row containing the game information
      }
    }
    return -1; // game not found
  }

  void setGameInfo(int row) { // input getName as parameter
      rank = getEntry(row, 0);
      URL = getEntry(row, 1);
      gameID = getEntry(row, 2);
      gameName = getEntry(row, 3);
      minPlayers = getEntry(row, 4);
      maxPlayers = getEntry(row, 5);
      avgTime = getEntry(row, 6);
      minTime = getEntry(row, 7);
      maxTime = getEntry(row, 8);
      year = getEntry(row, 9);
      restOfString = "\nRank: " + rank + "\nMinimum Players: " + minPlayers +
          "\nMaximum Players: " + maxPlayers + "\nAverage Time: " + avgTime + "\nMinimum Time: " + minTime +
          "\nMaximum Time: " + maxTime + "\nYear Released: " + year;
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  controller: nameInput,
                  decoration: const InputDecoration(
                    hintText: 'Game Search',
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:ElevatedButton(
                    child: Text('Search'),
                    onPressed: () {
                      if(getName(nameInput.text) == -1) { // Game not found
                        gameName = 'Game not found';
                      }
                      else { // Game found
                        setGameInfo(getName(nameInput.text));
                      }
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
                  "Game: " + gameName + restOfString,
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