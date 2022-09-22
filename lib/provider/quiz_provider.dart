import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import 'package:mathquiz/database/db_heloper.dart';
import '/model/quiz_data.dart';
import 'dart:math';

class QuizProvider extends ChangeNotifier {
  List<QuizData> _quizData = [];
  final Random _random = Random();

  QuizProvider() {
    getData();
  }

  void getData() async {
    DbHelper helper = DbHelper();
    _quizData = await helper.readData();

    for (var element in _quizData) {
      _refectorQuesTemp(element);
    }
  }

  void _refectorQuesTemp(QuizData data) {
    for (int a = 1; a <= data.totalValue; a++) {
      int value = _random.nextInt(100);
      data.values.add(value);
      data.ques=data.ques.replaceAll('V$a', value.toString());
    }
    _addOptions(data);
    notifyListeners();
  }
  void _addOptions(QuizData data){
    for(int a=1;a<=data.totalValue;a++){
      data.formula=data.formula.replaceAll('V$a',data.values[a-1].toString() );
    }
    int ans=data.formula.interpret().toInt();
    _makeOptions(data, ans);
  }
  void _makeOptions(QuizData data,int answer){
    data.options.add(answer);
    data.options.add(answer+5);
    data.options.add(answer-5);
    data.options.add(answer-10);

  }


  List<QuizData> get quizData => [..._quizData];
}
