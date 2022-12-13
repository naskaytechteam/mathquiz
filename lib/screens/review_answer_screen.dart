import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathquiz/widgets/common_widgets/custom_app_bar.dart';
import '/provider/template_factory.dart';
import '/screens/review_answer.dart';
import '../model/question.dart';

class ReviewAnswerScreen extends StatelessWidget {
  final List<Question> questions;

  const ReviewAnswerScreen({required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    int classNo = TemplateFactory().classNo;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Review Answers',
        height: height * 0.1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.11112),
        child: Column(
          children: [
            SizedBox(
              // height: 36,
              height: height * 0.04737,
            ),
            SizedBox(
              // height: 22,
              height: height * 0.029,
              width: width,
              child: Text(
                'Class $classNo - Logical Reasoning',
                style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline2?.fontFamily,
                    fontWeight: FontWeight.w900,
                    // fontSize: 16
                    fontSize: height * 0.0211),
              ),
            ),
            SizedBox(
              // height: 15,
              height: height * 0.01975,
            ),
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
                    fontFamily:
                        Theme.of(context).textTheme.headline2?.fontFamily,
                    // fontSize: 18
                    fontSize: height * 0.02369),
              ),
            ),
            SizedBox(
              // height: 30,
              height: height * 0.0395,
            ),
            SizedBox(
              // height: 520,
              height: height * 0.68422,
              width: width,
              child: ListView.builder(itemBuilder: (_, index) {
                return Container(
                  // height: 84,
                  height: height * 0.11053,
                  // width: 295,
                  width: width,
                  margin: EdgeInsets.only(bottom: /*22*/ height * 0.029),
                  //todo implement Question correct/wrong container shadow
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(236, 240, 241, 1),
                      borderRadius: BorderRadius.circular(/*25*/
                          height * 0.033),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, /* 7*/ height * 0.0093),
                            color: const Color.fromRGBO(39, 174, 96, 1))
                      ]),
                  alignment: Alignment.center,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return ReviewAnswer(questions: questions);
                      }));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: Text(
                      'Q.$index',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          // fontSize: 20,
                          fontSize: height * 0.0264,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.fontFamily),
                    ),
                    leading: SvgPicture.asset(
                      'assets/images/selected.svg',
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
}
