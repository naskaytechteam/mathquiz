import '../model/question_template.dart';

class TemplateParser {
  static List<QuestionTemplate> questionsTemplateList(
      List<Map<String, Object?>> map) {
    return map.map((e) => QuestionTemplate.fromMap(e)).toList();
  }

  static List<QuestionTemplate> questionsTemplateList(List<Map<String, Object?>> l) {
    return l.map((e) => _questionTemplate(e)).toList();
  }
}
