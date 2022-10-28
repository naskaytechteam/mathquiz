import 'dart:math';

import 'package:function_tree/function_tree.dart';

import '../database/db_helper.dart';
import '../model/question.dart';
import '../model/question_template.dart';
import '../model/util.dart';

enum TEMPLATE_TYPE {
  lcm,
  hcf,
  simple,
  fraction,
  ratio,
  ascendingdescendingdifference,
  sampletype
}

class TemplateFactory {
  static TemplateFactory? _instance;

  List<QuestionTemplate>? _templateList;
  final Random _random = Random();
  TEMPLATE_TYPE? _currentTemplateType;

  TemplateFactory._();

  factory TemplateFactory() {
    return _instance ??= TemplateFactory._();
  }

  Future<List<Question>> convertTemplatesToQuestions() async {
    return List.generate(_templateList!.length, (index) {
      var temp = _templateList![index];
      return Question(
          question: temp.ques, options: temp.options, answer: temp.answer!);
    }, growable: false);
  }

  Future<List<QuestionTemplate>> _fetchRawTemplatesFromDB(TEMPLATE_TYPE questype) {
    return DbHelper().readData(questype);
  }

  Future<List<Question>> generateQuestions(TEMPLATE_TYPE temp_type) async {
    _currentTemplateType = temp_type;
    _templateList ??= await _fetchRawTemplatesFromDB(temp_type);
    _populateTemplates();

    //////////////////// PENDING //////////////////////////
    _initAnswers();
    // _checkQuestionType(quesTemplateList[index]);

    return convertTemplatesToQuestions();
  }

  void _initAnswers() {
    _templateList?.forEach((element) {
      switch (_currentTemplateType!.index) {
        case 0:
          _makeLcmAnswer(element);
          break;
        case 1:
          // _hcfQuestion(element);
          break;
        case 2: //this is good than that
          _simpleQuestion(element);
          break;
        case 3:
          fraction(element);
          break;
        case 4:
          _ratioQuestion(element);
          break;
        case 5:
          _ascendingdescendingQues(element);
          break;
      }
    });
  }

  void _populateTemplates() {
    _templateList?.forEach((element) {
      _initPlaceHolders(element);
    });
  }

  void _initPlaceHolders(QuestionTemplate quesTemp) {
    _initRandomValues(quesTemp);
    for (int i = 0; i < quesTemp.valuePlaceholdersCount; i++) {
      _initFormula(quesTemp, i);
      _initQuestion(quesTemp, i);
    }
  }

  void _initRandomValues(QuestionTemplate temp) {
    temp.values.addAll(generateRandomValues(temp.valuePlaceholdersCount));
  }

  void _initFormula(QuestionTemplate questionTemplate, int placeHolderIndex) {
    //would it affect if I solve for lcm, hcf,etc.. & then place t in formula?
    var placeHolderValue = questionTemplate.values[placeHolderIndex].toString();
    questionTemplate.formula.replaceAll('V$placeHolderIndex', placeHolderValue);
  }

  void _initQuestion(QuestionTemplate questionTemplate, int placeHolderIndex) {
    var placeHolderValue = questionTemplate.values[placeHolderIndex].toString();
    questionTemplate.ques.replaceAll('V$placeHolderIndex', placeHolderValue);
  }

  Iterable<int> generateRandomValues(int size) sync* {
    while (size >= 0) {
      yield _random.nextInt(100) + 1;
      --size;
    }
  }

  void _checkQuestionType(QuestionTemplate template) {}

  ///////////////////////////////////////////////////////////////////////

  void _ascendingdescendingQues(QuestionTemplate quesTemp) {
    _makeascendingdescendingOQuesFormula(quesTemp);
    // _makeAnswer(quesTemp);
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
    // _changeValuePlaceholder(quesTemp);
    _makeRatioAnswer(quesTemp);
  }

  void _makeRatioAnswer(QuestionTemplate quesTemp) {
    String ratio = Util.ratio(quesTemp.values[0], quesTemp.values[1]);
    quesTemp.formula = quesTemp.formula.replaceAll('ratio', ratio.toString());
    // _makeAnswer(quesTemp);
  }

  void _hcf(QuestionTemplate data) {
    int hcf = Util.hcf(data.values[0], data.values[1]);
    data.formula = data.formula.replaceAll('hcf', hcf.toString());
    // _makeAnswer(data);
  }

  void _lcmQues(QuestionTemplate quesTemp) {
    // _changeValuePlaceholder(quesTemp);
    ;
  }

  void _makeLcmAnswer(QuestionTemplate quesTemp) {
    int? lcm;
    if (quesTemp.valuePlaceholdersCount == 3) {
      int firstLcm = Util.lcm(quesTemp.values[0], quesTemp.values[1]);
      lcm = Util.lcm(firstLcm, quesTemp.values[2]);
    } else if (quesTemp.valuePlaceholdersCount == 2) {
      lcm = Util.lcm(quesTemp.values[0], quesTemp.values[1]);
    }
    quesTemp.formula = quesTemp.formula.replaceAll('lcm', lcm.toString());
    // _makeAnswer(quesTemp);
  }

  void _simpleQuestion(QuestionTemplate quesTemp) {
    // if (_isContainName(quesTemp.ques)) {
    //   _questionContainsName(quesTemp);
    //   return;
    // }
    // _changeValuePlaceholder(quesTemp);
    // _makeAnswer(quesTemp);
  }

  void _makeAnswerPositive(QuestionTemplate quesTemp) {
    bool isAnswerPositive = _isAnswerPositive(quesTemp);
    int totalLoop = 5;
    for (int a = 1; a <= totalLoop; a++) {
      if (isAnswerPositive) {
        // _changeValuePlaceholder(quesTemp);
        // _makeAnswer(quesTemp);
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
    // _changeValuePlaceholder(quesTemp);
    // _makeAnswer(quesTemp);
  }

  void _removeQues(QuestionTemplate quesTemp) {
    // _quesTemplateList.remove(quesTemp);
    // if (_index! >= quesTemplateList.length) {
    //   return;
    // }
    // _simpleQuestion(quesTemplateList[_index!]);
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
}
