import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '/screens/score_screen.dart';
import 'package:provider/provider.dart';
import '../model/question_template.dart';
import '../provider/quiz_provider.dart';
import '/widgets/options.dart';
import '/widgets/current_ques_list.dart';
import '../widgets/app_bar.dart';

class QuesScreen extends StatefulWidget {
  final String quizType;

  const QuesScreen({required this.quizType, Key? key}) : super(key: key);

  @override
  State<QuesScreen> createState() => QuesScreenState();
}

class QuesScreenState extends State<QuesScreen> {
  num optionSelected = -1;
  int _quesIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    QuizProvider provider = Provider.of<QuizProvider>(context, listen: false);
    QuestionTemplate? quesTemp =
        provider.getQuestionTemplateForIndex(_quesIndex);

    if (_quesIndex >= provider.quesTemplateList.length) {
      return ScoreScreen(
        currentQuestionIndex: _quesIndex,
      );
    }

    return Scaffold(
      appBar: const Appbar(),
      backgroundColor: const Color.fromRGBO(54, 58, 102, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            _gap(height * 0.02),
            Image.asset(
              'assets/back.png',
              fit: BoxFit.fill,
              width: width,
              height: height * 0.2,
            ),
            _gap(height * 0.02),
            _buildQuesType(widget.quizType),
            _gap(height * 0.02),
            CurrentQuesList(
              index: _quesIndex,
              totalQuestion: provider.quesTemplateList.length,
            ),
            _gap(height * 0.03),
            _buildQuestion(quesTemp!.ques, height, width),
            Options(quesScreen: this, option: quesTemp.options),
            _gap(height * 0.03),
            _buildNextButton(height, width)
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(String ques, double height, double width) {
    return SizedBox(
      height: height * 0.18,
      width: width,
      child: AutoSizeText(
        ques,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNextButton(double height, double width) {
    return InkWell(
      onTap: _onNextButtonClick,
      child: Container(
        height: height * 0.07,
        width: width,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: const Text(
          'Next',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildQuesType(String quizType) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          quizType,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));
  }

  void _onNextButtonClick() {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: false);
    _checkAnswer(quizProvider);
    _increaseIndex(quizProvider);
  }

  void _increaseIndex(QuizProvider quizProvider) {
    if (_quesIndex < quizProvider.quesTemplateList.length - 1) {
      setState(() {
        _quesIndex++;
      });
      return;
    }
    showScore();
  }

  void _checkAnswer(QuizProvider quizProvider) {
    if (_quesIndex < quizProvider.quesTemplateList.length) {
      num answer = quizProvider.quesTemplateList[_quesIndex].answer!;
      if (optionSelected == answer) {
        quizProvider.increaseScore();
      }
    }
  }

  void showScore() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return ScoreScreen(
        currentQuestionIndex: currentQuestionIndex,
      );
    }));
  }

  int get currentQuestionIndex {
    return _quesIndex + 1;
  }

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
