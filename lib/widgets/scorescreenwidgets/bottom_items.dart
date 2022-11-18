import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mathquiz/screens/ques_screen.dart';
import '../../provider/template_factory.dart';
import '/widgets/pdf_design.dart';
import '/widgets/scorescreenwidgets/review_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/question.dart';
import '../../screens/review_answer.dart';

class BottomItems extends StatelessWidget {
  final List<Question> questions;
  final Function(BuildContext context) goToHomePage;

  const BottomItems(
      {required this.questions, required this.goToHomePage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Positioned(
        bottom: 0,
        child: SizedBox(
          height: height * 0.4,
          width: width,
          child: GridView.builder(
              padding: EdgeInsets.only(top: height * 0.05),
              itemCount: 6,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  mainAxisExtent: height * 0.14),
              itemBuilder: (_, index) {
                return Align(
                  child: _buildItems(height, width, index, context),
                );
              }),
        ));
  }

  Widget _buildItems(
      double height, double width, int index, BuildContext context) {
    return InkWell(
      onTap: () => _onItemSelected(height, width, index, context),
      child: SizedBox(
        height: height * 0.1,
        width: width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.primaries[index],
              // radius: width*0.08,
              radius: height * 0.03,
              child: Icon(_getIconData(index),
                  color: Colors.white, size: height * 0.03),
            ),
            Text(
              _getItemName(index),
              style: TextStyle(fontSize: height * 0.0175),
            )
          ],
        ),
      ),
    );
  }

  void _onItemSelected(
      double height, double width, int index, BuildContext context) async {
    NavigatorState navigatorState = Navigator.of(context);

    if (index == 0) {
      TemplateFactory templateFactory = TemplateFactory();
      templateFactory.resetScore();
      TemplateType currentQuestionsType = templateFactory.currentTemplateType;
      List<Question> newQuestionsList =
          await templateFactory.generateQuestions(currentQuestionsType);
      navigatorState.pushReplacement(MaterialPageRoute(builder: (_) {
        return QuesScreen(
            templateType: currentQuestionsType, questions: newQuestionsList);
      }));
    } else if (index == 1) {
      navigatorState.push(MaterialPageRoute(builder: (_) {
        return ReviewAnswer(
          questions: questions,
        );
      }));
    } else if (index == 2) {
      await Share.share('My MathQuiz Score is : 55');
    } else if (index == 3) {
      _generatePdf(navigatorState, height, width);
    } else if (index == 4) {
      goToHomePage(context);
    }
  }

  void _generatePdf(
      NavigatorState navigatorState, double height, double width) async {
    Directory directory = await getTemporaryDirectory();
    String path = await PdfDesign.makePdf(questions, directory.path);

    navigatorState.push(MaterialPageRoute(builder: (_) {
      return ReviewPDF(pdfPath: path);
    }));
  }

  String _getItemName(int index) {
    const textList = [
      'Play Again',
      'Review Answer',
      'Share Score',
      'Generate PDF',
      'Home',
      'Leaderboard'
    ];
    return textList[index];
  }

  IconData _getIconData(int index) {
    const iconList = [
      Icons.refresh,
      Icons.remove_red_eye,
      Icons.share,
      Icons.picture_as_pdf,
      Icons.home,
      Icons.star
    ];
    return iconList[index];
  }
}
