class QuesTemp {
  String ques;
  int valuePlaceholders;
  String formula;
  List<int> options = [];
  List<int> randomValues = [];
  int? answer;
  int quesType;

  QuesTemp(this.ques, this.formula, this.valuePlaceholders, this.quesType);

  factory QuesTemp.fromMap(Map<String, Object?> map) {
    return QuesTemp(map['ques'] as String, map['formula'] as String,
        map['value'] as int, map['quesType'] as int);
  }
}
