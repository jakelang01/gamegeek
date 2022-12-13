import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreen createState() => _TrackingScreen();
}

class _TrackingScreen extends State<TrackingScreen> {

  TextEditingController nameInput = TextEditingController();
  String gameName = '';
  String formattedDate = new DateFormat('LLL d, yyyy').format(new DateTime.now());
  String formattedTime = new DateFormat('kk:mm:ss').format(new DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$formattedDate'),
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
                        labelText: 'Game Name',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        floatingLabelStyle: Theme.of(context).textTheme.bodyText2
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child:ElevatedButton(
                      child: Text('Set'),
                      onPressed: () {
                        setState(() {
                          gameName = nameInput.text;
                        });
                      },
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Center(
                    child: Text(
                      'Name: $gameName'
                      '\nGame Start Time: $formattedTime',
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child:ElevatedButton(
                          child: Text('Start'),
                          onPressed: () {
                            // if statement that checks if timer is at 00:00:00 then sets formatTime
                            setState(() {
                              formattedTime = new DateFormat('kk:mm:ss').format(new DateTime.now());
                            });
                          },
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child:ElevatedButton(
                          child: Text('Stop'),
                          onPressed: () {
                            setState(() {

                            });
                          },
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child:ElevatedButton(
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {

                            });
                          },
                        )
                    ),
                  ],
                )
                  ],
                ),
              ),
          ),
    );
  }
}