class QuizData {
  String ques;
  int totalValues;
  String formula;
  List<int> options = [];
  List<int> values = [];
  int? answer;
  String quesType;

  QuizData(this.ques, this.formula, this.totalValues, this.quesType);

  factory QuizData.fromMap(Map<String, Object?> map) {
    return QuizData(map['ques'] as String, map['formula'] as String,
        map['value'] as int, map['quesType'] as String);
  }
}
