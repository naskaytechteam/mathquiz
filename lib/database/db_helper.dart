import 'dart:io';
import 'package:flutter/services.dart';
import '../model/question.dart';
import '/parsers/template_parser.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/model/question_template.dart';
import '../provider/template_factory.dart';

class DbHelper {
  Database? _database;
  static const int totalClass = 6;
  // static const String question = 'question';
  // static const String option1 = 'option1';
  // static const String option2 = 'option2';
  // static const String option3 = 'option3';
  // static const String option4 = 'option4';
  // static const String selectedIndex = 'selectedOptionIndex';
  // static const String answer = 'answer';
  // static const String index = '_index';
  // static const String classNo = 'classNo';
  // static const String quesType = 'quesType';
  static final DbHelper _dbHelper = DbHelper._();

  Future<Database> get database async {
    _database ??= await _getDatabase();
    return _database!;
  }

  DbHelper._();

  factory DbHelper() {
    return _dbHelper;
  }

  // Future<void> saveQuizData(
  //     int quesIndex, Question ques, int classNum, int questype) async {
  //   Database db = await database;
  //   await db.insert(
  //     'save_quiz',
  //     {
  //       index: quesIndex,
  //       question: ques.question,
  //       answer: ques.answer,
  //       selectedIndex: ques.selectedOptionIndex,
  //       option1: ques.options[0],
  //       option2: ques.options[1],
  //       option3: ques.options[2],
  //       option4: ques.options[3],
  //       classNo: classNum,
  //       quesType: questype
  //     },
  //   );
  // }

  // Future<void> deleteSavedData() async {
  //   Database db = await database;
  //   db.delete('save_quiz');
  // }

  // Future<List<Map<String, Object?>>> getSavedQuizData() async {
  //   Database db = await database;
  //   return db.query('save_quiz');
  // }

  Future<String> _getPath() async {
    return join(await getDatabasesPath(), 'sqlite.db');
  }

  Future<File> _createFile(File file) async {
    return file.create();
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
    File file = File(await _getPath());
    if (!await file.exists()) {
      await _writeData(await _createFile(file));
    }
    return await openDatabase(file.path, version: 1);
  }

  Future<List<int>> getQuestypeForClass(int classNo) async {
    Database db = await database;
    List<Map<String, Object?>> list =
        await db.rawQuery('select type from questype where class=$classNo');
    return _changeListType(list);
  }

  List<int> _changeListType(List<Map> list) {
    List<int> newList = list.map((e) => e['type'] as int).toList();
    return newList;
  }

  Future<List<QuestionTemplate>> readData(
      TemplateType quesType, int classNo) async {
    Database db = await database;
    List<Map<String, Object?>> map = await db.rawQuery(
        'select * from questemp  where quesType=${quesType.index} and class=$classNo ');

    List<QuestionTemplate> templateList =
        TemplateParser.questionsTemplateList(map);
    return templateList;
  }
}
