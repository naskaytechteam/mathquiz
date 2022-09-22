import 'package:flutter/foundation.dart';
import 'package:mathquiz/database/db_heloper.dart';
import '/model/quiz_data.dart';

class QuizProvider extends ChangeNotifier{
   List<QuizData> _quizData=[];
  QuizProvider(){
    getData();
  }
  void getData()async{
    DbHelper helper=DbHelper();
    _quizData=await helper.readData();
  }

  List<QuizData> get quizData=>[..._quizData];

}