import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import 'package:mathquiz/model/util.dart';
import '/database/db_helper.dart';
import '/model/ques_tenp.dart';
import 'dart:math';

enum QUESTYPE {
  lcm,
  hcf,
  simple,
  wordProblem,
  ratio,
  friction,
}

class QuizProvider extends ChangeNotifier {
  List<QuesTemp> _quizData = [];
  final Random _random = Random();

  QuizProvider() {

    _getData();
  }

  List<QuesTemp> get quizData => [..._quizData];

  void _getData() async {
    DbHelper helper = DbHelper();
    _quizData = await helper.readData();
    _refactorQuesTemp(_quizData);
  }

  void _hcfQuestion(QuesTemp data) {
    for (int a = 0; a < data.valuePlaceholders; a++) {
      int value = _random.nextInt(100);
      data.randomValues.add(value);
      data.ques = data.ques.replaceAll('V${a + 1}', value.toString());
    }
    _hcf(data);
  }

  void _hcf(QuesTemp data) {
        int hcf=Util.hcf(data.randomValues[0],data.randomValues[1]);
        String formula=data.formula.replaceAll('hcf', hcf.toString());
        int answer=formula.interpret().toInt();
      _makeOptions(data, answer);
  }

  void _refactorQuesTemp(List<QuesTemp> list) {
    for (int arr = 0; arr < list.length; arr++) {
      QuesTemp quesTemp = list[arr];
      if (QUESTYPE.hcf.index == quesTemp.quesType) {
        _hcfQuestion(quesTemp);
        continue;
      }
      else if(QUESTYPE.lcm.index==quesTemp.quesType) {

      }
      else if(QUESTYPE.simple.index==quesTemp.quesType) {
        _simpleQuestion(quesTemp);
      }
      else if(QUESTYPE.wordProblem.index==quesTemp.quesType) {
        bool isAnswerPositive=_wordProblemQues(quesTemp);
        if(!isAnswerPositive) {
          _quizData.remove(quesTemp);
          arr--;
          continue;
        }
      }
      _addOptions(quesTemp);
    }
  }

  void _simpleQuestion(QuesTemp data) {
    for (int sec = 0; sec < data.valuePlaceholders; sec++) {
      int randomValue = _random.nextInt(100);
      data.randomValues.add(randomValue);
      data.ques = data.ques
          .replaceAll('V${sec + 1}', data.randomValues[sec].toString());
    }
  }

  bool _isValueNegative(QuesTemp data) {
    String formula = data.formula;
    String ques = data.ques;
    for (int sec = 0; sec < data.valuePlaceholders; sec++) {
      int randomValue = _random.nextInt(100);
      data.randomValues.add(randomValue);
      ques = ques.replaceAll('V${sec + 1}', data.randomValues[sec].toString());
      formula =
          formula.replaceAll('V${sec + 1}', data.randomValues[sec].toString());
    }
    num answer = formula.interpret();
    bool checkAnswer = answer > 0;
    if (checkAnswer) {
      data.ques = ques;
    }
    return checkAnswer;
  }

  bool _wordProblemQues(QuesTemp data) {
    bool checkAnswer = _isValueNegative(data);
    if (checkAnswer) {
      return true;
    } else {
      for (int a = 0; a < 5; a++) {
        data.randomValues = []; //
        checkAnswer = _isValueNegative(data);
        if (checkAnswer) {
          break;
        }
      }
      return checkAnswer;
    }
  }

  void _addOptions(QuesTemp data) {
    for (int a = 1; a <= data.valuePlaceholders; a++) {
      data.formula =
          data.formula.replaceAll('V$a', (data.randomValues[a - 1]).toString());
    }
    int ans = data.formula.interpret().toInt();
    _makeOptions(data, ans);
  }

  void _makeOptions(QuesTemp data, int answer) {
    data.answer = answer;
    data.options.add(answer);
    data.options.add(answer + 5);
    data.options.add(answer - 5);
    data.options.add(answer - 10);
    _swipeOption(data);
  }

  void _swipeOption(QuesTemp data) {
    for (int a = 0; a < 2; a++) {
      int firstRandomValue = _random.nextInt(4);
      int getFirst = data.options[a];
      data.options[a] = data.options[firstRandomValue];
      data.options[firstRandomValue] = getFirst;
    }
    notifyListeners();
  }

}
