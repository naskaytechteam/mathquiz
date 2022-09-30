import '../model/ques_tenp.dart';

class QuizDataParser {
  static QuesTemp _data(Map<String, Object?> map) {
    return QuesTemp(map['ques'] as String, map['formula'] as String,
        map['valuePlaceholder'] as int, map['quesType'] as int);
  }

  static List<QuesTemp> quizDataList(List<Map<String, Object?>> l) {
    return l.map((e) => _data(e)).toList();
  }
}
