import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import '/parsers/template_parser.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/model/question_template.dart';
import '../provider/template_factory.dart';

class DbHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<String> _getPath() async {
    return join(await getDatabasesPath(), 'sqlite.db');
  }

  Future<File> _getFile() async {
    File file = File(await _getPath());
    if (!await file.exists()) {
      return file.create();
    }
    return file;
  }

  Future<Uint8List> _getAssetsDBFile() async {
    const assetsDBFileName = 'sqlite.db';
    ByteData byteData = await rootBundle.load(join('assets', assetsDBFileName));

    return byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  }

  Future<void> _writeData(File file) async {
    Uint8List data = await _getAssetsDBFile();
    await file.writeAsBytes(data);
  }

  Future<Database> _getDatabase() async {
    File file = await _getFile();
    await _writeData(file);
    return await openDatabase(file.path, version: 1);
  }

  Future<List<QuestionTemplate>> readData(TemplateType quesType) async {
    Database db = await database;
    List<Map<String, Object?>> map = await db
        .query('questemp', where: 'quesType=?', whereArgs: [quesType.index]);
    List<QuestionTemplate> templateList =
        TemplateParser.questionsTemplateList(map);
    return templateList;
  }
}
