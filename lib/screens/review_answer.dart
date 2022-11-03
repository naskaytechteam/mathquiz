import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../model/question.dart';
import '../widgets/quesscreenswidgets/app_bar.dart';
import '../widgets/quesscreenswidgets/current_ques_list.dart';

class ReviewAnswer extends StatefulWidget {
  final List<Question> questions;

  const ReviewAnswer({required this.questions, Key? key}) : super(key: key);

  @override
  State<ReviewAnswer> createState() => _ReviewAnswerState();
}

class _ReviewAnswerState extends State<ReviewAnswer> {
  int _quesIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    Question questionDetails = widget.questions[_quesIndex];

    return Scaffold(
      appBar: const Appbar(
        title: 'Review Answer',
      ),
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
            _gap(height * 0.02),
            CurrentQuesList(
              isReviewScreen: true,
              onCurrentQuesChange: (index) {
                setState(() {
                  _quesIndex = index;
                });
              },
              index: _quesIndex,
              totalQuestion: widget.questions.length,
            ),
            _gap(height * 0.03),
            _buildQuestion(questionDetails.question, height, width),
            _gap(height * 0.03),
            _buildOptions(height, width, questionDetails),
            _gap(height * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(double height, double width, Question question) {
    return SizedBox(
      height: height * 0.2,
      width: width,
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              mainAxisExtent: 70,
              crossAxisCount: 2),
          itemCount: 4,
          itemBuilder: (_, index) {
            return _buildOptionDesign(height, width, index, question);
          }),
    );
  }

  Widget _buildOptionDesign(
      double height, double width, int index, Question question) {
    return Container(
        decoration: BoxDecoration(
            color: question.answer == question.options[index]
                ? Colors.green
                : const Color.fromRGBO(56, 61, 110, 1),
            borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(
          question.options[index].toString(),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));
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

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
