// import '/database/db_helper.dart';

class Question {
  final String question;
  final List<num> options;
  int? _selectedOptionIndex;
  final num answer;

  set setSelectedOptionIndex(int index) {
    _selectedOptionIndex = index;
  }

  // Map<String, Object?> toMap() {
  //   return {
  //     DbHelper.question: question,
  //     DbHelper.answer: answer,
  //     DbHelper.selectedIndex: _selectedOptionIndex,
  //     DbHelper.option1: options[0],
  //     DbHelper.option2: options[1],
  //     DbHelper.option3: options[2],
  //     DbHelper.option4: options[3]
  //   };
  // }

  // static Question fromMap(Map<String, Object?> map) {
  //   return Question(
  //     question: map[DbHelper.question] as String,
  //     options: [
  //       map[DbHelper.option1] as num,
  //       map[DbHelper.option2] as num,
  //       map[DbHelper.option3] as num,
  //       map[DbHelper.option4] as num
  //     ],
  //     answer: map[DbHelper.answer] as num,
  //   ).._selectedOptionIndex = map[DbHelper.selectedIndex] as int?;
  // }

  int? get selectedOptionIndex => _selectedOptionIndex;

  Question(
      {required this.question, required this.options, required this.answer});
}
