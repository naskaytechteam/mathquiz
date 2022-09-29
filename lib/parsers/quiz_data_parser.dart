import '../model/quiz_data.dart';

class QuizDataParser {
  static QuizData _data(Map<String, Object?> map) {
    return QuizData(map['ques'] as String, map['formula'] as String,
        map['totalValues'] as int, map['quesType'] as String);
  }

  static List<QuizData> quizDataList(List<Map<String, Object?>> l) {
    return l.map((e) => _data(e)).toList();
  }
}
