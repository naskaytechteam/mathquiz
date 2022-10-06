import '../model/question_template.dart';

class QuizDataParser {
  static QuestionTemplate _data(Map<String, Object?> map) {
    return QuestionTemplate(map['ques'] as String, map['formula'] as String,
        map['valuePlaceholder'] as int, map['quesType'] as int);
  }

  static List<QuestionTemplate> quizDataList(List<Map<String, Object?>> l) {
    return l.map((e) => _data(e)).toList();
  }
}
