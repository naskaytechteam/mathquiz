import 'package:flutter/material.dart';
import '/widgets/ques_score_details.dart';
import 'package:provider/provider.dart';
import '../provider/quiz_provider.dart';

class ScoreDetails extends StatelessWidget {
  final int currentQuestionIndex;

  const ScoreDetails({required this.currentQuestionIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    int correctAnswer = quizProvider.score;
    int wrongAnswer = quizProvider.quesTemplateList.length - correctAnswer;
    int completation =
    (currentQuestionIndex * 100) ~/ quizProvider.quesTemplateList.length;
    return Align(
      child: Container(
        height: height * 0.2,
        width: width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 20,
                  color: Color.fromRGBO(56, 61, 110, 1)),
            ]),
        child: Column(
          children: [
            QuesScoreDetails(
                firstType: 'Conpletaion',
                secondType: 'Total Question',
                firstResult: '$completation%',
                secondResult: quizProvider.quesTemplateList.length.toString()),
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
