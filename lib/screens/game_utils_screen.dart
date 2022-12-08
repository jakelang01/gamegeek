import 'package:flutter/material.dart';
import 'dart:math';

class UtilsScreen extends StatefulWidget {
  @override
  _UtilsScreen createState() => _UtilsScreen();
}

TextEditingController nDice = TextEditingController(text: "3");
TextEditingController nSides = TextEditingController(text: "6");

class _UtilsScreen extends State<UtilsScreen> {

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Utilities'),
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 64, left: 8, right: 8),
            child: Text(
              "Incrementer"
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              child: Text("Dice Roller"),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context){
                          return DiceRollerScreen();
                        }));
              },
            ),
          )
        ],
      )
    );
  }
}

class DiceRollerScreen extends StatefulWidget {
  @override
  _DiceRollerScreen createState() => _DiceRollerScreen();
}

class _DiceRollerScreen extends State<DiceRollerScreen> {

  int nDiceInt = 3;
  int nSidesInt = 6;

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              //initialValue: "1",
              controller: nDice,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              //initialValue: "6",
              controller: nSides,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              child: Text("Roll!"),
              onPressed: (){
                nDiceInt = int.parse(nDice.text);
                nSidesInt = int.parse(nSides.text);
                //print(roller(nDiceInt, nSidesInt));
                Object object = Object();
              }
            )
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              roller(nDiceInt, nSidesInt),
            ),
          ),
        ],
      ),
    );
  }
}

String roller(int dice, int sides){
  int j = 0;
  if(dice > 0 && sides > 0){
    for(int i = 0; i<dice; i+=1){
      int temp = Random().nextInt(sides) + 1;
      //print(Random().nextInt(sides));
      j+= temp;
    }
    return j.toString();
  }
  else {
    return "0";
  }
}