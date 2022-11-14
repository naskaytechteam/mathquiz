import 'package:flutter/material.dart';
import '/widgets/scorescreenwidgets/bottom_items.dart';
import '/provider/template_factory.dart';
import '../model/question.dart';
import '../widgets/scorescreenwidgets/score_details.dart';
import '../widgets/scorescreenwidgets/your_point.dart';

class ScoreScreen extends StatelessWidget {
  final int questionNo;
  final List<Question> questions;

  const ScoreScreen(
      {required this.questionNo, required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            _buildYourScoreBackground(height, width, context),
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () => _goToHomePage(context),
                  icon: const Icon(Icons.arrow_back_outlined,
                      color: Colors.white),
                )),
            //(name) need to be change
            BottomItems(
              questions: questions,
              goToHomePage: _goToHomePage,
            ),
            const YourPoint(),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ScoreDetails(
                currentQuestionIndex: questionNo,
                questions: questions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYourScoreBackground(
      double height, double width, BuildContext context) {
    return Container(
      height: height * 0.5,
      width: width,
      decoration: BoxDecoration(
          // color: Color.fromRGBO(56, 61, 110, 1),
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
    );
  }

  void _goToHomePage(BuildContext context) {
    TemplateFactory().resetScore();
    Navigator.pop(context);
  }
}
