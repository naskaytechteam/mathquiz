// import '../model/question.dart';
import '../model/question_template.dart';

class TemplateParser {
  static List<QuestionTemplate> questionsTemplateList(
      List<Map<String, Object?>> map) {
    return map.map((e) => QuestionTemplate.fromMap(e)).toList();
  }

  // static List<Question> questionsList(List<Map<String, Object?>> map) {
  //   return map.map((e) => Question.fromMap(e)).toList();
  // }
}
