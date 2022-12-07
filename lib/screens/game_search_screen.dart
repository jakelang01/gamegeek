import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class GameInfoData {
  List<List<dynamic>>? rawData;
  String dataFilePath = 'assets/bgg_db_2018_01.csv';

  Future<void> readDataFile() async {
    var bytes = await rootBundle.load(dataFilePath);
    String bytesAsString = utf8.decode(bytes.buffer.asUint8List());
    rawData = const CsvToListConverter().convert(bytesAsString);
  }

}