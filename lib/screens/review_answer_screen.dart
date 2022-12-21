import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathquiz/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '/provider/template_factory.dart';
import '/screens/review_answer.dart';
import '../model/question.dart';

class ReviewAnswerScreen extends StatelessWidget {
  final List<Question> questions;

  const ReviewAnswerScreen({required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final TemplateFactory templateFactory = TemplateFactory();
    final int classNo = templateFactory.classNo;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Review Answers',
        height: height * 0.1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.11112),
        child: Column(
          children: [
            _buildGap(height * 0.04737),
            SizedBox(
              // height: 22,
              height: height * 0.029,
              width: width,
              child: Text(
                'Class $classNo - ${templateFactory.currentTemplateType.name}',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    // fontSize: 16
                    fontSize: height * 0.0211),
              ),
            ),
            _buildGap(height * 0.01975),
            SizedBox(
              // height: 50,
              height: height * 0.0658,
              width: width,
              child: Text.rich(
                const TextSpan(text: 'You answered ', children: [
                  TextSpan(
                      text: '9/10 ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'questions correctly')
                ]),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    // fontSize: 18
                    fontSize: height * 0.02369),
              ),
            ),
            _buildGap(height * 0.0395),
            SizedBox(
              // height: 520,
              height: height * 0.68422,
              width: width,
              child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (_, index) {
                    int selectedOptionIndex =
                        questions[index].selectedOptionIndex!;
                    bool isAnswerCorrect = questions[index].answer ==
                        questions[index].options[selectedOptionIndex];
                    String image =
                        isAnswerCorrect ? 'selected' : 'wrong_answer';
                    return CustomButton(
                      height: height * 0.11053,
                      width: width,
                      onButtonPressed: () => _onButtonClick(context, index),
                      backgroundColor: const Color.fromRGBO(236, 240, 241, 1),
                      shadowColor: isAnswerCorrect
                          ? const Color.fromRGBO(39, 174, 96, 1)
                          : const Color.fromRGBO(192, 57, 43, 1),
                      shadowHeight: height * 0.0093,
                      margin: EdgeInsets.only(bottom: /*22*/ height * 0.029),
                      child: ListTile(
                        trailing: const Icon(Icons.arrow_forward_ios),
                        title: Text(
                          'Q.${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            // fontSize: 20,
                            fontSize: height * 0.0264,
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/$image.svg',
                          // height: 21,
                          height: height * 0.02764,
                          // width: 22,
                          width: width * 0.06112,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _onButtonClick(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ReviewAnswer(
        questions: questions,
        quesIndex: index,
      );
    }));
  }

  Widget _buildGap(double height) {
    return SizedBox(height: height);
  }
}
