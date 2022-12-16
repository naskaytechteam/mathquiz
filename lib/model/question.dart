class Question {
  final String question;
  final List<num> options;
  int? _selectedOptionIndex;
  final num answer;

  set setSelectedOptionIndex(int index) {
    _selectedOptionIndex = index;
  }

  int? get selectedOptionIndex => _selectedOptionIndex;

  Question(
      {required this.question, required this.options, required this.answer});
}
