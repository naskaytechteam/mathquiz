class QuestionTemplate {
  String ques;
  int valuePlaceholders;
  String formula;
  List<int> options = [];
  List<int> randomValues = [];
  int? answer;
  int quesType;

  QuestionTemplate(this.ques, this.formula, this.valuePlaceholders, this.quesType);

  factory QuestionTemplate.fromMap(Map<String, Object?> map) {
    return QuestionTemplate(map['ques'] as String, map['formula'] as String,
        map['value'] as int, map['quesType'] as int);
  }
}
