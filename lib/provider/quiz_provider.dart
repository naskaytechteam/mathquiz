import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import '/model/util.dart';
import '/database/db_helper.dart';
import '/model/question_template.dart';
import 'dart:math';

enum QUESTYPE {
  lcm,
  hcf,
  simple,
  fraction,
  ratio,
  ascendingdescendingdifference,
  sampletype
}

//We can make this class as Singleton instead of changeNotifier
//Now that it is a changeNotifier we can take advantage of that to notify a change such as being out of templates.
class QuizProvider with ChangeNotifier {
  List<QuestionTemplate> _quesTemplateList = [];
  final Random _random = Random();
  int? _index;
  int _score = 0;

  int get score => _score;

  List<QuestionTemplate> get quesTemplateList => [..._quesTemplateList];

  Future<void> readDataFromDatabase(QUESTYPE questype) async {
    DbHelper dbHelper = DbHelper();
    _quesTemplateList = await dbHelper.readData(questype);
    _resetScore();
  }

  void _resetScore() {
    _score = 0;
  }

  QuestionTemplate? getQuestionTemplateForIndex(int index) {
    _index = index;
    _checkQuestionType(quesTemplateList[index]);

    if (index >= quesTemplateList.length) {
      return null;
    }

    return quesTemplateList[index];
  }

  void increaseScore() {
    _score++;
  }

  void _checkQuestionType(QuestionTemplate quesTemp) {
    switch (quesTemp.quesType) {
      case 0:
        _lcmQues(quesTemp);
        break;
      case 1:
        _hcfQuestion(quesTemp);
        break;
      case 2: //this is good than that
        _simpleQuestion(quesTemp);
        break;
      case 3:
        fraction(quesTemp);
        break;
      case 4:
        _ratioQuestion(quesTemp);
        break;
      case 5:
        _ascendingdescendingQues(quesTemp);
        break;
    }
  }

  void _ascendingdescendingQues(QuestionTemplate quesTemp) {
    _changeValuePlaceholder(quesTemp);
    _makeascendingdescendingOQuesFormula(quesTemp);
    _makeAnswer(quesTemp);
  }

  void _makeascendingdescendingOQuesFormula(QuestionTemplate quesTemp) {
    int asc = _ascendingOrder(quesTemp);
    int des = _descendingOrder(quesTemp);
    quesTemp.formula = quesTemp.formula.replaceAll('ascending', asc.toString());
    quesTemp.formula =
        quesTemp.formula.replaceAll('descending', des.toString());
  }

  int _ascendingOrder(QuestionTemplate quesTemp) {
    StringBuffer stringBuffer = StringBuffer();
    for (int a = 0; a < quesTemp.valuePlaceholdersCount; a++) {
      for (int b = a + 1; b < quesTemp.valuePlaceholdersCount; b++) {
        if (quesTemp.randomValues[a] > quesTemp.randomValues[b]) {
          int firstValue = quesTemp.randomValues[a];
          quesTemp.randomValues[a] = quesTemp.randomValues[b];
          quesTemp.randomValues[b] = firstValue;
        }
      }
      stringBuffer.write(quesTemp.randomValues[a]);
    }
    return int.parse(stringBuffer.toString());
  }

  int _descendingOrder(QuestionTemplate quesTemp) {
    StringBuffer stringBuffer = StringBuffer();
    for (int a = 0; a < quesTemp.valuePlaceholdersCount; a++) {
      for (int b = a + 1; b < quesTemp.valuePlaceholdersCount; b++) {
        if (quesTemp.randomValues[a] < quesTemp.randomValues[b]) {
          int firstValue = quesTemp.randomValues[a];
          quesTemp.randomValues[a] = quesTemp.randomValues[b];
          quesTemp.randomValues[b] = firstValue;
        }
      }
      stringBuffer.write(quesTemp.randomValues[a]);
    }
    return int.parse(stringBuffer.toString());
  }

  void fraction(QuestionTemplate quesTemp) {
    quesTemp.options.add(1);
    quesTemp.options.add(1);
    quesTemp.options.add(1);
    quesTemp.options.add(1);
  }

  void _ratioQuestion(QuestionTemplate quesTemp) {
    _changeValuePlaceholder(quesTemp);
    _makeRatioAnswer(quesTemp);
  }

  void _makeRatioAnswer(QuestionTemplate quesTemp) {
    String ratio =
        Util.ratio(quesTemp.randomValues[0], quesTemp.randomValues[1]);
    quesTemp.formula = quesTemp.formula.replaceAll('ratio', ratio.toString());
    _makeAnswer(quesTemp);
  }

  void _hcf(QuestionTemplate data) {
    int hcf = Util.hcf(data.randomValues[0], data.randomValues[1]);
    data.formula = data.formula.replaceAll('hcf', hcf.toString());
    _makeAnswer(data);
  }

  void _lcmQues(QuestionTemplate quesTemp) {
    _changeValuePlaceholder(quesTemp);
    _makeLcmAnswer(quesTemp);
  }

  void _makeLcmAnswer(QuestionTemplate quesTemp) {
    int? lcm;
    if (quesTemp.valuePlaceholdersCount == 3) {
      int firstLcm =
          Util.lcm(quesTemp.randomValues[0], quesTemp.randomValues[1]);
      lcm = Util.lcm(firstLcm, quesTemp.randomValues[2]);
    } else if (quesTemp.valuePlaceholdersCount == 2) {
      lcm = Util.lcm(quesTemp.randomValues[0], quesTemp.randomValues[1]);
    }
    quesTemp.formula = quesTemp.formula.replaceAll('lcm', lcm.toString());
    _makeAnswer(quesTemp);
  }

  void _simpleQuestion(QuestionTemplate quesTemp) {
    if (_isContainName(quesTemp.ques)) {
      _questionContainsName(quesTemp);
      return;
    }
    _changeValuePlaceholder(quesTemp);
    _makeAnswer(quesTemp);
  }

  void _makeAnswerPositive(QuestionTemplate quesTemp) {
    bool isAnswerPositive = _isAnswerPositive(quesTemp);
    int totalLoop = 5;
    for (int a = 1; a <= totalLoop; a++) {
      if (isAnswerPositive) {
        _changeValuePlaceholder(quesTemp);
        _makeAnswer(quesTemp);
        return;
      }
      if (a == totalLoop) {
        _removeQues(quesTemp);
        break;
      }
      isAnswerPositive = _isAnswerPositive(quesTemp);
    }
  }

  void _questionContainsName(QuestionTemplate quesTemp) {
    if (!_isAnswerPositive(quesTemp)) {
      _makeAnswerPositive(quesTemp);
      return;
    }
    _changeValuePlaceholder(quesTemp);
    _makeAnswer(quesTemp);
  }

  void _removeQues(QuestionTemplate quesTemp) {
    _quesTemplateList.remove(quesTemp);
    if (_index! >= quesTemplateList.length) {
      return;
    }
    _simpleQuestion(quesTemplateList[_index!]);
  }

  bool _isAnswerPositive(QuestionTemplate quesTemp) {
    String formula = quesTemp.formula;
    quesTemp.randomValues = [];
    for (int arr = 1; arr <= quesTemp.valuePlaceholdersCount; arr++) {
      int randomValue = _random.nextInt(100);
      quesTemp.randomValues.add(randomValue);
      formula = formula.replaceAll('V$arr', randomValue.toString());
    }
    int answer = formula.interpret().toInt();
    return answer > 0;
  }

  void _changeValuePlaceholder(QuestionTemplate quesTemp) {
    for (int arr = 1; arr <= quesTemp.valuePlaceholdersCount; arr++) {
      if (quesTemp.randomValues.length < quesTemp.valuePlaceholdersCount) {
        _makeRandomValue(quesTemp);
      }
      _changeQuesValuePlaceholder(quesTemp, arr);
      _changeFormulaValuePlaceholder(quesTemp, arr);
    }
  }

  void _makeRandomValue(QuestionTemplate quesType) {
    int randomValue = _random.nextInt(100);
    quesType.randomValues.add(randomValue);
  }

  void _changeFormulaValuePlaceholder(QuestionTemplate quesTemp, int index) {
    quesTemp.formula = quesTemp.formula
        .replaceAll('V$index', (quesTemp.randomValues[index - 1]).toString());
  }

  void _changeQuesValuePlaceholder(QuestionTemplate quesTemp, int index) {
    quesTemp.ques = quesTemp.ques
        .replaceAll('V$index', quesTemp.randomValues[index - 1].toString());
  }

  void _makeAnswer(QuestionTemplate quesTemp) {
    int answer = quesTemp.formula.interpret().toInt();
    quesTemp.answer = answer;
    _makeOptions(quesTemp);
  }

  void _makeOptions(QuestionTemplate quesTemp) {
    num answer = quesTemp.answer!;

    quesTemp.options.add(answer);
    quesTemp.options.add(answer - 5);
    quesTemp.options.add(answer + 5);
    quesTemp.options.add(answer - 3);
    _swipeOptions(quesTemp.options);
  }

  void _swipeOptions(List<num> options) {
    for (int a = 0; a < 2; a++) {
      int randomValue = _random.nextInt(options.length);
      num value = options[a];
      options[a] = options[randomValue];
      options[randomValue] = value;
    }
  }

  bool _isContainName(String ques) {
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

  void _hcfQuestion(QuestionTemplate data) {
    _changeValuePlaceholder(data);
    _hcf(data);
  }
}
