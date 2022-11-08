import 'package:flutter/material.dart';
import '../../model/question.dart';
import '/provider/template_factory.dart';
import 'ques_score_details.dart';

class ScoreDetails extends StatelessWidget {
  final int currentQuestionIndex;
  final List<Question> questions;

  const ScoreDetails(
      {required this.currentQuestionIndex, required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    TemplateFactory templateFactory = TemplateFactory();
    int correctAnswer = templateFactory.score;

    int wrongAnswer = questions.length - correctAnswer;
    int completion = (currentQuestionIndex * 100) ~/ questions.length;

    return Align(
      child: Container(
        height: height * 0.2,
        width: width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 10,
                  color: Color.fromRGBO(56, 61, 110, 0.5)),
            ]),
        child: Column(
          children: [
            QuesScoreDetails(
                firstType: 'Completion',
                secondType: 'Total Question',
                firstResult: '$completion%',
                secondResult: questions.length.toString()),
            QuesScoreDetails(
              firstType: 'Correct',
              secondType: 'Wrong',
              firstResult: correctAnswer.toString(),
              secondResult: wrongAnswer.toString(),
              firstTextColor: Colors.green,
              secondTextColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
