import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(
            'Your Score is ${quizProvider.score} out of'
            ' ${quizProvider.quesTemplateList.length}',

            style: const TextStyle(fontSize: 30)),
      ),
    );
  }
}
