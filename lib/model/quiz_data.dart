class QuizData {
  String ques;
  int totalValue;
  String formula;
  List<num> options = [];
  List<int> values = [];
  String? answer;

  QuizData(this.ques, this.formula, this.totalValue);

  factory QuizData.fromMap(Map<String, Object> map) {
    return QuizData(
        map['ques'] as String, map['formula'] as String, map['value']as int);
  }

}
