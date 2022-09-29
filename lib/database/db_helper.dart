import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import '/model/quiz_data.dart';
import '/parsers/quiz_data_parser.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;

  Future<Database> get database async{
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'sqlite.db');
    File file = File(path);
    bool isFileExist = await file.exists();
    if (!isFileExist) {
      await file.create();
    }
    ByteData assetBundle = await rootBundle.load(join('assets', 'sqlite.db'));
    Uint8List dataList = assetBundle.buffer
        .asUint8List(assetBundle.offsetInBytes, assetBundle.lengthInBytes);
    await file.writeAsBytes(dataList);
    return await openDatabase(path,version: 1);
  }

  Future<List<QuizData>> readData()async{
    Database db=await database;
    List<Map<String,Object?>>map=await db.query('questemp');
    List<QuizData>qData= QuizDataParser.quizDataList(map);
    return qData;
  }
}
