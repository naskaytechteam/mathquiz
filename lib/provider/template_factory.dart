import 'dart:math';
import 'package:function_tree/function_tree.dart';
import '../database/db_helper.dart';
import '../model/question.dart';
import '../model/question_template.dart';
import '../model/util.dart';

/// Init random values first, get answer from formula but just use the formula
/// to calculate answer, don't initialize it or anything, for simple questions
/// if answer is not correct just re init the random values
enum TemplateType {
  lcm,
  hcf,
  simple,
  fraction,
  ratio,
  ascendingdescendingdifference,
}

class TemplateFactory {
  static TemplateFactory? _instance;
  int? classNo;

  List<QuestionTemplate>? _templateList;
  final Random _random = Random();
  TemplateType? _currentTemplateType;
  int _score = 0;

  TemplateFactory._();

  TemplateType get currentTemplateType => _currentTemplateType!;

  factory TemplateFactory() {
    return _instance ??= TemplateFactory._();
  }

  int get score => _score;

  void increaseScore() {
    _score++;
  }

  void resetScore() {
    _score = 0;
  }

  Future<List<Question>> _convertTemplatesToQuestions() async {
    return List.generate(_templateList!.length, (index) {
      var temp = _templateList![index];
      return Question(
          question: temp.ques, options: temp.options, answer: temp.answer!);
    }, growable: false);
  }

  Future<List<QuestionTemplate>> _fetchRawTemplatesFromDB(
      TemplateType questype) {
    return DbHelper().readData(questype, classNo!);
  }

  Future<List<Question>> generateQuestions(TemplateType tempType) async {
    _currentTemplateType = tempType;
    _templateList = await _fetchRawTemplatesFromDB(tempType);
    _populateTemplates();

    if (tempType == TemplateType.simple) {
      _selectQuestionWithNotEmptyOption();
    }

    return _convertTemplatesToQuestions();
  }

  void _selectQuestionWithNotEmptyOption() {
    _templateList =
        _templateList?.where((element) => element.options.length == 4).toList();
  }

  void _populateTemplates() {
    _templateList?.forEach((template) {
      _initRandomValues(template);
      template.answer = _getAnswer(template);
      if (_currentTemplateType == TemplateType.simple &&
          _isContainName(template.ques) &&
          !_isAnswerPositive(template.answer!)) {
        _tryToMakeAnswerPositive(template);
        return;
      }
      _initQuestion(template);
      _makeOptions(template);
    });
  }

  void _tryToMakeAnswerPositive(QuestionTemplate quesTemp) {
    bool isAnswerPositive = _makeAnswerPositive(quesTemp);
    if (isAnswerPositive) {
      _initQuestion(quesTemp);
      _makeOptions(quesTemp);
    }
  }

  bool _makeAnswerPositive(QuestionTemplate quesTemp) {
    int totalRetry = 5;
    for (int i = 1; i <= totalRetry; i++) {
      _initRandomValues(quesTemp);
      num answer = _getAnswer(quesTemp);
      if (_isAnswerPositive(answer)) {
        quesTemp.answer = answer;
        return true;
      }
    }
    return false;
  }

  bool _isContainName(String ques) {
    List<String> names = [' she ', ' he ', ' his ', ' her ', ' him ', ' it '];
    Iterable iterable = names.where((element) => ques.contains(element));
    return iterable.isNotEmpty;
  }

  void _initRandomValues(QuestionTemplate temp) {
    temp.values.clear();
    temp.values.addAll(_generateRandomValues(
        temp.valuePlaceholdersCount, temp.startRange, temp.endRange));
  }

  num _getAnswer(QuestionTemplate template) {
    var formula = template.formula;
    if (_currentTemplateType == TemplateType.hcf) {
      int hcf = Util.hcf(template.values);
      formula = formula.replaceAll('hcf', '$hcf');
    } else if (_currentTemplateType == TemplateType.lcm) {
      int lcm = Util.lcm(template.values);
      formula = formula.replaceAll('lcm', '$lcm');
    } else if (_currentTemplateType == TemplateType.ratio) {
      //need to refactor ratio question
    } else if (_currentTemplateType ==
        TemplateType.ascendingdescendingdifference) {
      int asc = Util.reduceList(values: template.values);
      int des = Util.reduceList(
          values: template.values, sortOrder: SortOrder.descending);
      formula = formula
          .replaceAll('ascending', asc.toString())
          .replaceAll('descending', des.toString());
    } else {
      for (int i = 1; i <= template.valuePlaceholdersCount; i++) {
        var placeHolderValue = template.values[i - 1].toString();
        formula = formula.replaceAll('V$i', placeHolderValue);
      }
    }
    num answer = formula.interpret();
    return _typeCastValue(answer);
  }

  num _typeCastValue(num answer) {
    num a = answer.compareTo(answer.toInt()) == 0
        ? answer.toInt()
        : double.parse(answer.toStringAsFixed(3));
    return a;
  }

  void _initQuestion(QuestionTemplate questionTemplate) {
    for (int i = 1; i <= questionTemplate.valuePlaceholdersCount; i++) {
      var placeHolderValue = questionTemplate.values[i - 1].toString();
      questionTemplate.ques =
          questionTemplate.ques.replaceAll('V$i', placeHolderValue);
    }
  }

  Iterable<int> _generateRandomValues(
      int size, int startRange, int endRange) sync* {
    while (size > 0) {
      yield _random.nextInt(endRange - startRange) + startRange;
      --size;
    }
  }

  // void _makeAnswerPositive(QuestionTemplate quesTemp) {
  //   int totalRetry = 5;
  //   for (int i = 1; i <= totalRetry; i++) {
  //     _initRandomValues(quesTemp);
  //     int answer = _getAnswer(quesTemp);
  //     if (_isAnswerPositive(answer)) {
  //       quesTemp.answer = answer;
  //       return;
  //     }
  //   }
  // }

  void _makeOptions(QuestionTemplate quesTemp) {
    num answer = quesTemp.answer!;
    quesTemp.options.add(answer);
    quesTemp.options.add(_typeCastValue(answer - 5));
    quesTemp.options.add(_typeCastValue(answer + 5));
    quesTemp.options.add(_typeCastValue(answer - 3));
    _swapOptions(quesTemp.options);
  }

  void _swapOptions(List<num> options) {
    for (int a = 0; a < 2; a++) {
      int randomValue = _random.nextInt(options.length);
      num value = options[a];
      options[a] = options[randomValue];
      options[randomValue] = value;
    }
  }

  Future<List<int>> getQuesTypes(int classNo) {
    this.classNo = classNo;
    return DbHelper().getQuestypeForClass(classNo);
  }

  bool _isAnswerPositive(num answer) {
    return answer > 0;
  }
}
