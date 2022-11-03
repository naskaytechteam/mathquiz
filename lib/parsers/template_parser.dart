import '../model/question_template.dart';

class TemplateParser {
  static QuestionTemplate _questionTemplate(Map<String, Object?> map) {
    return QuestionTemplate.fromMap(map);
  }

  static List<QuestionTemplate> questionsTemplateList(List<Map<String, Object?>> l) {
    return l.map((e) => _questionTemplate(e)).toList();
  }
}
