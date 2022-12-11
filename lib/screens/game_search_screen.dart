import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:game_geek/screens/advanced_search_screen.dart';

final databaseReference = FirebaseFirestore.instance.collection("Data");

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {

  int rank = 0;
  String URL = '';
  String gameName = '';
  int minPlayers = 0;
  int maxPlayers = 0;
  int avgTime = 0;
  int year = 0;
  double rating = 0;
  String nameText = '';
  TextEditingController nameInput = TextEditingController();

  Future<int> getRank(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    int thing = data.get('rank');
    return Future.value(thing);
  }

  Future<String> getURL(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    String thing = data.get('bgg_url');
    return Future.value(thing);
  }

  Future<double> getAvgRating(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    double thing = data.get('avg_rating');
    return Future.value(thing);
  }

  Future<int> getMinPlayers(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    int thing = data.get('min_players');
    return Future.value(thing);
  }

  Future<int> getMaxPlayers(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    int thing = data.get('max_players');
    return Future.value(thing);
  }

  Future<int> getAvgTime(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    int thing = data.get('max_players');
    return Future.value(thing);
  }

  Future<int> getYear(String name) async {
    String nameDoc = name;
    DocumentSnapshot data =  await databaseReference.doc(nameDoc).get();
    int thing = data.get('max_players');
    return Future.value(thing);
  }

  Future<void> setGameInfo(String name) async {
    var rankData = await getRank(name);
    var urlData = await getURL(name);
    var minPlayersData = await getMinPlayers(name);
    var maxPlayersData = await getMaxPlayers(name);
    var avgTimeData = await getAvgTime(name);
    var yearData = await getYear(name);
    var ratingData = await getAvgRating(name);

    setState(() {
      rank = rankData;
      URL = urlData;
      gameName = name;
      minPlayers = minPlayersData;
      maxPlayers = maxPlayersData;
      avgTime = avgTimeData;
      year = yearData;
      rating = ratingData;
    });
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
        body: Padding(
            padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
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
                            nameText = nameInput.text;
                            setGameInfo(nameText);
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
                        'Name: $gameName' + '\nRank: $rank' + '\nURL: $URL' + '\nYear Released: $year' +
                            '\nRating: $rating' + '\nAverage Time: $avgTime' + '\nMinimum Players: $minPlayers' + '\nMaximum Players: $maxPlayers',
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                        textScaleFactor: 0.5,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ]
                ),

              ),
            ),
    );
  }
}