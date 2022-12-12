import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

final databaseReference = FirebaseFirestore.instance.collection("Data");
const int searchLimit = 10; // change this to change the number of results displayed

class AdvancedSearchScreen extends StatefulWidget {

  AdvancedSearchScreen({required Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AdvancedSearchScreen createState() => _AdvancedSearchScreen();
}

class _AdvancedSearchScreen extends State<AdvancedSearchScreen> {

  int rank = 0;
  String URL = '';
  String gameName = '';
  int minPlayers = 0;
  int maxPlayers = 0;
  int avgTime = 0;
  int year = 0;
  double rating = 0;
  String nameText = '';
  TextEditingController numInput = TextEditingController();

  List<Widget> results = [];

  // searchLimit games that allow at least num players
  Future<void> numPlayerSearch(int num) async {
    QuerySnapshot searchResult = await databaseReference
        // .where('min_players',isLessThanOrEqualTo: num) // can only have one of these for some reason
        .where('max_players',isGreaterThanOrEqualTo: num)
        // .orderBy('avg_rating') // also can't do this it turns out.
        .limit(searchLimit).get();
    List<DocumentSnapshot> resultDocs = searchResult.docs;
    results = [];
    int i = 1;
    for (var doc in resultDocs) {
      results.add(createResult(doc,i));
      i++;
    }
    setState(() {});
  }

  // searchLimit shortest games
  Future<void> ascTimeSearch() async {
    QuerySnapshot searchResult = await databaseReference
        .orderBy('avg_time').limit(searchLimit).get();
    List<DocumentSnapshot> resultDocs = searchResult.docs;
    results = [];
    int i = 1;
    for (var doc in resultDocs) {
      results.add(createResult(doc,i));
      i++;
    }
    setState(() {});
  }

  // searchLimit longest games
  Future<void> descTimeSearch() async {
    QuerySnapshot searchResult = await databaseReference
        .orderBy('avg_time',descending: true).limit(searchLimit).get();
    List<DocumentSnapshot> resultDocs = searchResult.docs;
    results = [];
    int i = 1;
    for (var doc in resultDocs) {
      results.add(createResult(doc,i));
      i++;
    }
    setState(() {});
  }

  Widget createResult(DocumentSnapshot doc, int docIndex) {
    var name = doc.get('names');
    var rankData = doc.get('rank');
    var urlData = doc.get('bgg_url');
    var minPlayersData = doc.get('min_players');
    var maxPlayersData = doc.get('max_players');
    var avgTimeData = doc.get('avg_time');
    var yearData = doc.get('year');
    var ratingData = doc.get('avg_rating');
    return Center(
      child: Text(
        '-$docIndex-'
        '\nName: $name'
            '\nRank: $rankData'
            '\nURL: $urlData'
            '\nYear Released: $yearData'
            '\nRating: $ratingData'
            '\nAverage Time: $avgTimeData'
            '\nMinimum Players: $minPlayersData'
            '\nMaximum Players: $maxPlayersData\n',
        textAlign: TextAlign.center,
        //overflow: TextOverflow.ellipsis,
        textScaleFactor: 0.75,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextFormField(
                    controller: numInput,
                    decoration: const InputDecoration(
                      hintText: 'Number of Players',
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ElevatedButton(
                      child: Text('Search'),
                      onPressed: () {
                        numPlayerSearch(int.parse(numInput.value.text));
                      },
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: ElevatedButton(
                      child: Text('View highest average times'),
                      onPressed: () {
                        descTimeSearch();
                      },
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ElevatedButton(
                      child: Text('View lowest average times'),
                      onPressed: () {
                        ascTimeSearch();
                      },
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(children: results,)
                ),
              ]
          ),
        ),
      ),
    );
  }
}
