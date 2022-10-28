import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import 'package:mathquiz/provider/template_factory.dart';

import '/database/db_helper.dart';
import '/model/question_template.dart';
import '/model/util.dart';

// enum QUESTYPE {
//   lcm,
//   hcf,
//   simple,
//   fraction,
//   ratio,
//   ascendingdescendingdifference,
//   sampletype
// }

/// Steps to make a Question from a QuestionTemplate :
/// 1) fetch templates from DB (for a given type).
/// 2) Generate random values (could be any range)
/// 3) Solve the question with the populated values from the given formula
/// (template has a "formula" field)... (There is is an exception).
/// 4) change placeholder(refers to all placeholders i.e. formula, question, values.
/// Template has a placeholderCount field to fetch the number of placeholders in a template.)
/// of question with generated random values (The template should only populate
/// itself once the user has moved to that question).
/// 5) Generate options: Options are random values near the correct answer.
/// 6) Randomize the option list with correct answer and options so the correct answer
/// position is always random on UI.
///
/// 7) Voilaaa!!! Your question is ready! :D
///
/// Exceptional Case:
/// For Question with Non - Negative types:
/// 1) Same procedure till step 4 from above. if the answer cannot be -ve then
/// set a limit for re-generating the answer.

//We can make this class as Singleton instead of changeNotifier
//Now that it is a changeNotifier we can take advantage of that to notify a change such as being out of templates.
class QuizProvider with ChangeNotifier {
  List<QuestionTemplate> _quesTemplateList = [];
  final Random _random = Random();
  int? _index;
  int _score = 0;

  int get score => _score;

  List<QuestionTemplate> get quesTemplateList => _quesTemplateList;

  Future<void> readDataFromDatabase(QUESTYPE questype) async {
    DbHelper dbHelper = DbHelper();
    _quesTemplateList = await dbHelper.readData(questype);
    // _resetScore();
  }

  void resetScore() {
    _score = 0;
  }
/// this method change current index question template with ques
  QuestionTemplate? getQuestionTemplateForIndex(int index) {
    _index = index;
    _checkQuestionType(quesTemplateList[index]);
/// if our last question is removed from list than this index will be == quesTemplateList.length and
    /// this will return null
    if (index >= quesTemplateList.length) {
      return null;
    }

    return quesTemplateList[index];
  }
///
  void increaseScore() {
    _score++;
  }
///this method will check the type of question and will do further operation on that like changeValuePlaceHolder etc.
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
        if (quesTemp.values[a] > quesTemp.values[b]) {
          int firstValue = quesTemp.values[a];
          quesTemp.values[a] = quesTemp.values[b];
          quesTemp.values[b] = firstValue;
        }
      }
      stringBuffer.write(quesTemp.values[a]);
    }
    return int.parse(stringBuffer.toString());
  }

  int _descendingOrder(QuestionTemplate quesTemp) {
    StringBuffer stringBuffer = StringBuffer();
    for (int a = 0; a < quesTemp.valuePlaceholdersCount; a++) {
      for (int b = a + 1; b < quesTemp.valuePlaceholdersCount; b++) {
        if (quesTemp.values[a] < quesTemp.values[b]) {
          int firstValue = quesTemp.values[a];
          quesTemp.values[a] = quesTemp.values[b];
          quesTemp.values[b] = firstValue;
        }
      }
      stringBuffer.write(quesTemp.values[a]);
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
        Util.ratio(quesTemp.values[0], quesTemp.values[1]);
    quesTemp.formula = quesTemp.formula.replaceAll('ratio', ratio.toString());
    _makeAnswer(quesTemp);
  }

  void _hcf(QuestionTemplate data) {
    int hcf = Util.hcf(data.values[0], data.values[1]);
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
          Util.lcm(quesTemp.values[0], quesTemp.values[1]);
      lcm = Util.lcm(firstLcm, quesTemp.values[2]);
    } else if (quesTemp.valuePlaceholdersCount == 2) {
      lcm = Util.lcm(quesTemp.values[0], quesTemp.values[1]);
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
    /// this will check 1st time that the answer of this quesTemp is positive or negative if negative than we will try to make answer positive
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
    quesTemp.values = [];
    for (int arr = 1; arr <= quesTemp.valuePlaceholdersCount; arr++) {
      int randomValue = _random.nextInt(100);
      quesTemp.values.add(randomValue);
      formula = formula.replaceAll('V$arr', randomValue.toString());
    }
    int answer = formula.interpret().toInt();
    return answer > 0;
  }

  void _changeValuePlaceholder(QuestionTemplate quesTemp) {
    for (int arr = 1; arr <= quesTemp.valuePlaceholdersCount; arr++) {
      if (quesTemp.values.length < quesTemp.valuePlaceholdersCount) {
        _makeRandomValue(quesTemp);
      }
      _changeQuesValuePlaceholder(quesTemp, arr);
      _changeFormulaValuePlaceholder(quesTemp, arr);
    }
  }

  void _makeRandomValue(QuestionTemplate quesType) {
    int randomValue = _random.nextInt(100);
    quesType.values.add(randomValue);
  }

  void _changeFormulaValuePlaceholder(QuestionTemplate quesTemp, int index) {
    quesTemp.formula = quesTemp.formula
        .replaceAll('V$index', (quesTemp.values[index - 1]).toString());
  }

  void _changeQuesValuePlaceholder(QuestionTemplate quesTemp, int index) {
    quesTemp.ques = quesTemp.ques
        .replaceAll('V$index', quesTemp.values[index - 1].toString());
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
/// this method is for swipe our answer(option) place
  void _swipeOptions(List<num> options) {
    for (int a = 0; a < 2; a++) {
      int randomValue = _random.nextInt(options.length);
      num value = options[a];
      options[a] = options[randomValue];
      options[randomValue] = value;
    }
  }

  bool _isContainName(String ques) {
    print(ques);
    List<String> names = [' she ', ' he ', ' his ', ' her ', ' him ', ' it '];
    Iterable iterable = names.where((element) => ques.contains(element));
    print(iterable.isEmpty);
    return iterable.isNotEmpty;
  }

  void _hcfQuestion(QuestionTemplate data) {
    _changeValuePlaceholder(data);
    _hcf(data);
  }
}
