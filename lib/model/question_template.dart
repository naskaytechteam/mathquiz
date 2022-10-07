class QuestionTemplate {
  String ques;
  int valuePlaceholdersCount;
  String formula;
  List<num> options = [];
  List<int> randomValues = [];
  num? answer;
  int quesType;

  QuestionTemplate(this.ques, this.formula, this.valuePlaceholdersCount, this.quesType);

  factory QuestionTemplate.fromMap(Map<String, Object?> map) {
    return QuestionTemplate(map['ques'] as String, map['formula'] as String,
        map['value'] as int, map['quesType'] as int);
  }
}
