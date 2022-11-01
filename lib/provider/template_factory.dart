import 'dart:math';
import 'package:function_tree/function_tree.dart';
import '../database/db_helper.dart';
import '../model/question.dart';
import '../model/question_template.dart';
import '../model/util.dart';

/// Init random values first, get answer from formula but just use the formula
/// to calculate answer, don't initialize it or anything, for simple questions
/// if answer is not correct just re init the random values
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

  Future<List<QuestionTemplate>> _fetchRawTemplatesFromDB(
      TEMPLATE_TYPE questype) {
    return DbHelper().readData(questype);
  }

  Future<List<Question>> generateQuestions(TEMPLATE_TYPE temp_type) async {
    _currentTemplateType = temp_type;
    _templateList = await _fetchRawTemplatesFromDB(temp_type);
    _populateTemplates();

    //////////////////// PENDING //////////////////////////
    // _initAnswers();
    // _checkQuestionType(quesTemplateList[index]);
    if (temp_type == TEMPLATE_TYPE.simple) {
      _selectQuestionWithNotEmptyOption();
    }

    return convertTemplatesToQuestions();
  }

  void _selectQuestionWithNotEmptyOption() {
    _templateList =
        _templateList?.where((element) => element.options.length == 4).toList();
  }

  void _populateTemplates() {
    _templateList?.forEach((template) {
      _initRandomValues(template);
      template.answer = _getAnswer(template);
      if (_currentTemplateType == TEMPLATE_TYPE.simple &&
          _isContainName(template.ques) &&
          !_isAnswerPositive(template.answer!)) {
        _tryToMakeAnswerPositive(template);
        return;
      }

      _initQuestion(template);
      _makeOptions(template);
      // _initPlaceHolders(template);
    });
  }

  void _tryToMakeAnswerPositive(QuestionTemplate quesTemp) {
    _initRandomValues(quesTemp);
    _makeAnswerPositive(quesTemp);
  }

  bool _isContainName(String ques) {
    List<String> names = [' she ', ' he ', ' his ', ' her ', ' him ', ' it '];
    Iterable iterable = names.where((element) => ques.contains(element));
    return iterable.isNotEmpty;
  }

  void _initRandomValues(QuestionTemplate temp) {
    temp.values.clear();
    temp.values.addAll(generateRandomValues(temp.valuePlaceholdersCount));
  }

  int _getAnswer(QuestionTemplate template) {
    var formula = template.formula;
    if (_currentTemplateType == TEMPLATE_TYPE.hcf) {
      int hcf = Util.hcf(template.values);
      formula = formula.replaceAll('hcf', '$hcf');
    } else if (_currentTemplateType == TEMPLATE_TYPE.lcm) {
      int lcm = Util.lcm(template.values);
      formula = formula.replaceAll('lcm', '$lcm');
    } else if (_currentTemplateType == TEMPLATE_TYPE.ratio) {
    } else if (_currentTemplateType ==
        TEMPLATE_TYPE.ascendingdescendingdifference) {
      /// logic need to be change
      // int asc = Util.reduceList(values: template.values);
      // int des = Util.reduceList(
      //     values: template.values, sortOrder: SortOrder.descending);
      // formula = formula
      //     .replaceAll('ascending', asc.toString())
      //     .replaceAll('descending', des.toString());
    } else {
      for (int i = 1; i <= template.valuePlaceholdersCount; i++) {
        var placeHolderValue = template.values[i - 1].toString();
        formula = formula.replaceAll('V$i', placeHolderValue);
      }
    }
    return formula.interpret().toInt();
  }

  void _initQuestion(QuestionTemplate questionTemplate) {
    for (int i = 1; i <= questionTemplate.valuePlaceholdersCount; i++) {
      var placeHolderValue = questionTemplate.values[i - 1].toString();
      questionTemplate.ques =
          questionTemplate.ques.replaceAll('V$i', placeHolderValue);
    }
  }

  Iterable<int> generateRandomValues(int size) sync* {
    while (size > 0) {
      yield _random.nextInt(100) + 1;
      --size;
    }
  }

  ///////////////////////////////////////////////////////////////////////

  void fraction(QuestionTemplate quesTemp) {
    quesTemp.options.add(1);
    quesTemp.options.add(1);
    quesTemp.options.add(1);
    quesTemp.options.add(1);
  }

  void _makeAnswerPositive(QuestionTemplate quesTemp) {
    int totalRetry = 5;
    for (int i = 1; i <= totalRetry; i++) {
      int answer = _getAnswer(quesTemp);
      if (_isAnswerPositive(answer)) {
        quesTemp.answer = answer;
        break;
      }
      if (i == totalRetry) {
        return;
      }
      _initRandomValues(quesTemp);
    }
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

  bool _isAnswerPositive(num answer) {
    return answer > 0;
  }
}
