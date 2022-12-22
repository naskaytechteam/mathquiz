import 'dart:io';
import 'package:flutter/services.dart';
import '/parsers/template_parser.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/model/question_template.dart';
import '../provider/template_factory.dart';

class DbHelper {
  static Database? _database;
  static const int totalClass = 6;
  static const String question = 'question';
  static const String option1 = 'option1';
  static const String option2 = 'option2';
  static const String option3 = 'option3';
  static const String option4 = 'option4';
  static const String selectedIndex = 'selectedOptionIndex';
  static const String answer = 'answer';
  static const String index = '_index';
  static const String classNo='classNo';
  static const String quesType='quesType';

  Future<Database> get database async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<void> saveQuizData(int quesIndex, Question questions,int classNum,int questype) async {
    Database db = await database;
    await db.insert(
      'save_quiz',
      {
        index: quesIndex,
        question: questions.question,
        answer: questions.answer,
        selectedIndex: questions.selectedOptionIndex,
        option1: questions.options[0],
        option2: questions.options[1],
        option3: questions.options[2],
        option4: questions.options[3],
        classNo:classNum,
        quesType:questype
      },
    );
  }

  Future<void> deleteSavedData() async {
    Database db = await database;
    db.delete('save_quiz');
  }

  // Future<List<Question>> get getQuestions async {
  //   Database db = await database;
  //   List<Map<String, Object?>> getSavedData = await db.query('save_quiz');
  //   return TemplateParser.questionsList(getSavedData);
  // }
  Future<List<Map<String, Object?>>> getSavedQuizData() async {
    Database db = await database;

    return db.query('save_quiz');
  }

  // Future<int?> get getIndex async {
  //   Database db = await database;
  //   List<Map<String, Object?>> list =
  //       await db.rawQuery('select _index from save_quiz');
  //   return list.isNotEmpty ? list[0]['_index'] as int : null;
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
