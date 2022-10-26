import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/model/question_template.dart';
import '/parsers/quiz_data_parser.dart';
import '../provider/template_factory.dart';

class DbHelper {
  static Database? _database;

  Future<Database> get database async {
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
    return await openDatabase(path, version: 1);
  }

  Future<List<QuestionTemplate>> readData(TEMPLATE_TYPE quesType) async {
    Database db = await database;
    List<Map<String, Object?>> map = await db
        .query('questemp', where: 'quesType=?', whereArgs: [quesType.index]);
    List<QuestionTemplate> qData = QuizDataParser.quizDataList(map);
    return qData;
  }
}
