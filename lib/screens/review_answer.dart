import 'package:flutter/material.dart';
import '/widgets/commonwidgets/build_question.dart';
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
      appBar: Appbar(
        height: height,
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
            BuildQuestion(ques: questionDetails.question),
            _gap(height * 0.03),
            // this is same as Option (widget) class
            _buildOptions(height, width, questionDetails),
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
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              mainAxisExtent: height*0.09,
              crossAxisCount: 2),
          itemCount: question.options.length,
          itemBuilder: (_, index) {
            return _buildOptionDesign(height, width, index, question);
          }),
    );
  }

  Widget _buildOptionDesign(
      double height, double width, int index, Question question) {
    return Align(
      child: Container(
        height: height*0.08,
          width: width*0.5,
          decoration: BoxDecoration(
              color: question.answer == question.options[index]
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(height*0.025)),
          alignment: Alignment.center,
          child: Text(
            question.options[index].toString(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
