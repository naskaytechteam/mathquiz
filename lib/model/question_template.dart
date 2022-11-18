class QuestionTemplate {
  String ques;
  int valuePlaceholdersCount;
  String formula;
  List<num> options = [];
  List<int> values = [];
  num? answer;
  int quesType;
  int startRange;
  int endRange;

  QuestionTemplate(this.ques, this.formula, this.valuePlaceholdersCount,
      this.quesType, this.startRange, this.endRange);

  factory QuestionTemplate.fromMap(Map<String, Object?> map) {
    return QuestionTemplate(
        map['ques'] as String,
        map['formula'] as String,
        map['valuePlaceholder'] as int,
        map['quesType'] as int,
        map['startRange'] as int,
        map['endRange'] as int);
  }
}
