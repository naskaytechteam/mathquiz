import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import '/database/db_heloper.dart';
import '/model/quiz_data.dart';
import 'dart:math';

class QuizProvider extends ChangeNotifier {
  List<QuizData> _quizData = [];
  final Random _random = Random();

  QuizProvider() {
    _getData();
  }

  List<QuizData> get quizData => [..._quizData];

  void _getData() async {
    DbHelper helper = DbHelper();
    _quizData = await helper.readData();
    _refactorQuesTemp(_quizData);
  }

  void _refactorQuesTemp(List<QuizData> list) {
    for (int arr = 0; arr < list.length; arr++) {
      QuizData data = list[arr];
      if (_isNameContain(data.ques)) {
        bool isValuePositive = _nameQuestion(data);
        if (!isValuePositive) {
          bool a = list.remove(data);
          if (a) {
            arr--;
          }
          continue;
        }
      } else {
        _simpleQuestion(data);
      }
      _addOptions(data);
    }
  }

  void _simpleQuestion(QuizData data) {
    for (int sec = 0; sec < data.totalValue; sec++) {
      int randomValue = _random.nextInt(100);
      data.values.add(randomValue);
      data.ques =
          data.ques.replaceAll('V${sec + 1}', data.values[sec].toString());
    }
  }

  bool _isValueNegative(QuizData data) {
    String formula = data.formula;
    String ques = data.ques;
    for (int sec = 0; sec < data.totalValue; sec++) {
      int randomValue = _random.nextInt(100);
      data.values.add(randomValue);
      ques = ques.replaceAll('V${sec + 1}', data.values[sec].toString());
      formula = formula.replaceAll('V${sec + 1}', data.values[sec].toString());
    }
    num answer = formula.interpret();
    bool checkAnswer = answer > 0;
    if (checkAnswer) {
      data.ques = ques;
    }

    return checkAnswer;
  }

  bool _nameQuestion(QuizData data) {
    bool checkAnswer = _isValueNegative(data);
    if (checkAnswer) {
      return true;
    } else {
      for (int a = 0; a < 5; a++) {
        data.values = []; //
        checkAnswer = _isValueNegative(data);
        if (checkAnswer) {
          break;
        }
      }
      return checkAnswer;
    }
  }

  void _addOptions(QuizData data) {
    for (int a = 1; a <= data.totalValue; a++) {
      data.formula =
          data.formula.replaceAll('V$a', (data.values[a - 1]).toString());
    }

    int ans = data.formula.interpret().toInt();
    _makeOptions(data, ans);
  }

  void _makeOptions(QuizData data, int answer) {
    data.answer = answer;
    data.options.add(answer);
    data.options.add(answer + 5);
    data.options.add(answer - 5);
    data.options.add(answer - 10);
    _swipeOption(data);
  }

  void _swipeOption(QuizData data) {
    for (int a = 0; a < 2; a++) {
      int firstRandomValue = _random.nextInt(4);
      int getFirst = data.options[a];
      data.options[a] = data.options[firstRandomValue];
      data.options[firstRandomValue] = getFirst;
    }
    notifyListeners();
  }

  bool _isNameContain(String name) {
    List<String> list = [
      ' has ',
      ' she ',
      ' he ',
      ' have ',
      ' his ',
      ' are ',
      ' her '
    ];
    Iterable iterable = list.where((element) => name.contains(element));
    return iterable.isNotEmpty;
  }
}
