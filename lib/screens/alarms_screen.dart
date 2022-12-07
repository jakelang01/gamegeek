import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

/*****************************************************************************************************/
/*                                                                                                   */
/*  Alarm clock code taken from https://www.geeksforgeeks.org/flutter-building-an-alarm-clock-app/   */
/*                                                                                                   */
/*****************************************************************************************************/


class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreen createState() => _AlarmScreen();
}

class _AlarmScreen extends State<AlarmScreen>{

  //text controllers
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext build){
    return Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(11)
                    ),
                    child: Center(
                      child: TextField(
                        controller: hourController,
                        keyboardType: TextInputType.number,
                        ),
                      ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(11)
                    ),
                    child: Center(
                      child: TextField(
                        controller: minuteController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Create alarm',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    int hour;
                    int minutes;
                    hour = int.parse(hourController.text);
                    minutes = int.parse(minuteController.text);
                    FlutterAlarmClock.createAlarm(hour, minutes);
                  },
                ),
              ),
          ],
        ),
    );
  }

}