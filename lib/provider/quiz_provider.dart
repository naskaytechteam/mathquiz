import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import '/model/util.dart';
import '/database/db_helper.dart';
import '/model/ques_tenp.dart';
import 'dart:math';

enum QUESTYPE { lcm, hcf, simple, friction,ratio , add }

class QuizProvider extends ChangeNotifier {
  List<QuesTemp> _quizData = [];
  final Random _random = Random();
  late int _index;

  List<QuesTemp> get quizData => [..._quizData];

  Future<void> getQuesType(QUESTYPE questype) async {
    DbHelper dbHelper = DbHelper();
    _quizData = await dbHelper.readData(questype);
  }

  QuesTemp? getQuestionTemp(int index) {
    QuesTemp? quesTemp;
    _index = index;
    if (index < _quizData.length) {
      _findQuestionType(quizData[_index]);
      quesTemp = quizData[_index];
    }
    return quesTemp;
  }

  void _findQuestionType(QuesTemp quesTemp) {
    switch (quesTemp.quesType) {
      case 0:
        _lcmQues(quesTemp);
        return;
      case 1:
        _hcfQuestion(quesTemp);
        return;
      case 2:
        simpleQuestion(quesTemp);
        return;
      case 3:
        return;
      case 4:
        fric(quesTemp);
        return;
      case 5:
        return;
    }
  }

  void fric(QuesTemp quesTemp) {
    quesTemp.options.add(1);
    quesTemp.options.add(1);
    quesTemp.options.add(1);
    quesTemp.options.add(1);
  }

  void _ratioQuestion(QuesTemp quesTemp) {
    for (int a = 1; a <= quesTemp.valuePlaceholders; a++) {
      int randomValue = _random.nextInt(100);
      quesTemp.randomValues.add(randomValue);
      quesTemp.ques = quesTemp.ques.replaceAll('V$a', randomValue.toString());
    }
    _makeRatioAnswer(quesTemp);
  }

  void _makeRatioAnswer(QuesTemp quesTemp) {
    String ratio =
        Util.ratio(quesTemp.randomValues[0], quesTemp.randomValues[1]);
  }

  void _hcf(QuesTemp data) {
    int hcf = Util.hcf(data.randomValues[0], data.randomValues[1]);
    String formula = data.formula.replaceAll('hcf', hcf.toString());
    int answer = formula.interpret().toInt();
    makeOptions(data, answer);
  }

  void _lcmQues(QuesTemp quesTemp) {
    for (int a = 1; a <= quesTemp.valuePlaceholders; a++) {
      int randomValue = _random.nextInt(100);
      while (randomValue == 0) {
        randomValue = _random.nextInt(100);
      }
      quesTemp.randomValues.add(randomValue);
      quesTemp.ques = quesTemp.ques.replaceAll('V$a', randomValue.toString());
    }

    _makeLcmAnswer(quesTemp);
  }

//todo IntegerDivisionByZeroException can we occurred
  void _makeLcmAnswer(QuesTemp quesTemp) {
    int? lcm;
    if (quesTemp.valuePlaceholders == 3) {
      int firstLcm =
          Util.lcm(quesTemp.randomValues[0], quesTemp.randomValues[1]);
      lcm = Util.lcm(firstLcm, quesTemp.randomValues[2]);
    } else if (quesTemp.valuePlaceholders == 2) {
      lcm = Util.lcm(quesTemp.randomValues[0], quesTemp.randomValues[1]);
    }
    quesTemp.answer = lcm.toString().interpret().toInt();
    makeOptions(quesTemp, quesTemp.answer!);
  }

  void simpleQuestion(QuesTemp quesTemp) {
    bool isNameQuestion = isContainName(quesTemp.ques);
    if (isNameQuestion) {
      wordProblemQuestion(quesTemp); //changeValueForPositive()
      return;
    }
    changeValuePlaceholder(quesTemp);
  }

  void wordProblemQuestion(QuesTemp quesTemp) {
    bool isValuePositive = getValueType(quesTemp);
    if (!isValuePositive) {
      skipQuestion();
      return;
    }
    changeValuePlaceholder(quesTemp);
  }

  void skipQuestion() {
    if (_index < _quizData.length - 1) {
      _index++;
      getQuestionTemp(_index);
      return;
    }
    _index--;
  }

  bool getValueType(QuesTemp quesTemp) {
    String ques = quesTemp.ques;
    String formula = quesTemp.formula;
    for (int arr = 1; arr <= quesTemp.valuePlaceholders; arr++) {
      int randomValue = _random.nextInt(100);
      quesTemp.randomValues.add(randomValue);
      formula = formula.replaceAll('V$arr', randomValue.toString());
    }
    num answer = formula.interpret();
    bool isAnswerPositive = answer > 0;
    if (isAnswerPositive) {
      quesTemp.ques = ques;
    }
    return isAnswerPositive;
  }

  void changeValuePlaceholder(QuesTemp quesTemp) {
    for (int arr = 1; arr <= quesTemp.valuePlaceholders; arr++) {
      changeQuesValuePlaceholder(quesTemp, arr);
      changeFormulaValuePlaceholder(quesTemp, arr);
    }
    makeAnswer(quesTemp);
  }

  void changeFormulaValuePlaceholder(QuesTemp quesTemp, int index) {
    quesTemp.formula = quesTemp.formula
        .replaceAll('V$index', (quesTemp.randomValues[index - 1]).toString());
  }

  void changeQuesValuePlaceholder(QuesTemp quesTemp, int index) {
    int randomValue = _random.nextInt(100);
    quesTemp.randomValues.add(randomValue);
    quesTemp.ques = quesTemp.ques.replaceAll('V$index', randomValue.toString());
  }

  void makeAnswer(QuesTemp quesTemp) {
    int answer = quesTemp.formula.interpret().toInt();
    makeOptions(quesTemp, answer);
  }

  void makeOptions(QuesTemp quesTemp, int answer) {
    quesTemp.options.add(answer);
    quesTemp.options.add(answer - 5);
    quesTemp.options.add(answer + 5);
    quesTemp.options.add(answer - 3);
    swipeOptions(quesTemp.options);
  }

  void swipeOptions(List<num> options) {
    for (int a = 0; a < 2; a++) {
      int randomValue = _random.nextInt(options.length);
      num value = options[a];
      options[a] = options[randomValue];
      options[randomValue] = value;
    }
  }

  bool isContainName(String ques) {
    List<String> names = [
      ' she ',
      ' he ',
      ' his ',
      ' her ',
      ' him ',
    ];
    Iterable iterable = names.where((element) => ques.contains(element));
    return iterable.isNotEmpty;
  }

  // void _simpleQuestion(QuesTemp data) {
  //   // There should be 2 checks either questions has a name placeholder or questions has a pronoun
  //   if (isNameContain(data.ques)) {
  //     bool isValuePositive = _wordProblemQues(data);
  //     if (!isValuePositive) {
  //       bool a = _quizData.remove(data);
  //       print('is ques removed ${a}');
  //       if (_index < _quizData.length) {
  //         // _index++;
  //         getQuestionTemp(_index);
  //         // return;
  //       }
  //     }
  //   }
  //   addRandomValue(data);
  // }

  // void addRandomValue(QuesTemp quesTemp) {
  //   for (int a = 0; a < quesTemp.valuePlaceholders; a++) {
  //     int randomValue = _random.nextInt(100);
  //     quesTemp.randomValues.add(randomValue);
  //     quesTemp.ques =
  //         quesTemp.ques.replaceAll('V${a + 1}', randomValue.toString());
  //   }
  //   _addOptions(quesTemp);
  // }

  bool _isValueNegative(QuesTemp data) {
    String formula = data.formula;
    String ques = data.ques;
    for (int sec = 0; sec < data.valuePlaceholders; sec++) {
      int randomValue = _random.nextInt(100);
      data.randomValues.add(randomValue);
      ques = ques.replaceAll('V${sec + 1}', randomValue.toString());
      formula = formula.replaceAll('V${sec + 1}', randomValue.toString());
    }
    int answer = formula.interpret().toInt();
    bool checkAnswer = answer > 0;
    if (checkAnswer) {
      data.ques = ques;
      data.answer = answer;
    }
    return checkAnswer;
  }

  bool _wordProblemQues(QuesTemp data) {
    bool checkAnswer = _isValueNegative(data);
    if (checkAnswer) {
      return true;
    } else {
      for (int a = 0; a < 5; a++) {
        data.randomValues = [];
        checkAnswer = _isValueNegative(data);
        print('is value Positive $checkAnswer');
        if (checkAnswer) {
          break;
        }
      }
      return checkAnswer;
    }
  }

  void _hcfQuestion(QuesTemp data) {
    for (int a = 0; a < data.valuePlaceholders; a++) {
      int value = _random.nextInt(100);
      data.randomValues.add(value);
      data.ques = data.ques.replaceAll('V${a + 1}', value.toString());
    }
    _hcf(data);
  }

// void _addOptions(QuesTemp data) {
//   for (int a = 1; a <= data.valuePlaceholders; a++) {
//     data.formula =
//         data.formula.replaceAll('V$a', (data.randomValues[a - 1]).toString());
//   }
//   int ans = data.formula.interpret().toInt();
//   _makeOptions(data, ans);
// }

// void _makeOptions(QuesTemp data, int answer) {
//   data.answer = answer;
//   data.options.add(answer);
//   data.options.add(answer + 5);
//   data.options.add(answer - 5);
//   data.options.add(answer - 10);
//   _swipeOption(data);
// }

// void _swipeOption(QuesTemp data) {
//   for (int a = 0; a < 2; a++) {
//     int firstRandomValue = _random.nextInt(4);
//     int getFirst = data.options[a];
//     data.options[a] = data.options[firstRandomValue];
//     data.options[firstRandomValue] = getFirst;
//   }
//   // notifyListeners();
// }

// bool isNameContain(String name) {
//   List<String> names = [
//     ' she ',
//     ' he ',
//     ' his ',
//     ' her ',
//     ' him ',
//   ];
//   Iterable iterable = names.where((element) => name.contains(element));
//   return iterable.isNotEmpty;
// }
}
