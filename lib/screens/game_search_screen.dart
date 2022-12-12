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

  Future<void> setGameInfo(String name) async {
    DocumentSnapshot data =  await databaseReference.doc(name).get();
    var rankData = data.get('rank');
    var urlData = data.get('bgg_url');
    var minPlayersData = data.get('min_players');
    var maxPlayersData = data.get('max_players');
    var avgTimeData = data.get('avg_time');
    var yearData = data.get('year');
    var ratingData = data.get('avg_rating');

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
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    controller: nameInput,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
                        labelText: 'Game Search',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        floatingLabelStyle: Theme.of(context).textTheme.bodyText2
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child:ElevatedButton(
                      child: Text('Search'),
                      onPressed: () {
                        nameText = nameInput.text;
                        setGameInfo(nameText);
                      },
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Center(
                    child: Text(
                      'Name: $gameName'
                          '\nRank: $rank'
                          '\nURL: $URL'
                          '\nYear Released: $year'
                          '\nRating: $rating'
                          '\nAverage Time: $avgTime'
                          '\nMinimum Players: $minPlayers'
                          '\nMaximum Players: $maxPlayers',
                      textAlign: TextAlign.center,
                      //overflow: TextOverflow.ellipsis,
                      textScaleFactor: 0.75,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}