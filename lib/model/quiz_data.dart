class QuizData {
  String ques;
  int totalValue;
  String formula;
  List<int> options = [];
  List<int> values = [];
  int? answer;

  QuizData(this.ques, this.formula, this.totalValue);

  factory QuizData.fromMap(Map<String, Object?> map) {
    return QuizData(
        map['ques'] as String, map['formula'] as String, map['value']as int);
  }

}
