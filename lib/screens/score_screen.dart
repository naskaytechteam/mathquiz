import 'dart:io';
import 'package:flutter/material.dart';
import '/provider/quiz_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:provider/provider.dart';
import '/screens/review_answer.dart';
import '../widgets/scorescreenwidgets/score_details.dart';
import '../widgets/scorescreenwidgets/your_point.dart';

class ScoreScreen extends StatelessWidget {
  final int currentQuestionIndex;

  const ScoreScreen({required this.currentQuestionIndex, Key? key})
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
            _buildYourScore(height, width),
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined,
                      color: Colors.white),
                )),
            Positioned(
              bottom: 0,
              child: _buildBottomWidget(height, width, context),
            ),
            YourPoint(),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ScoreDetails(currentQuestionIndex: currentQuestionIndex),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYourScore(double height, double width) {
    return Container(
      height: height * 0.5,
      width: width,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(56, 61, 110, 1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
    );
  }

//refactor Name
  Widget _buildSixWidget(
      double height, double width, int index, BuildContext context) {
    List<IconData> iconList = [
      Icons.refresh,
      Icons.remove_red_eye,
      Icons.share,
      Icons.picture_as_pdf,
      Icons.home,
      Icons.star
    ];
    List<String> textList = [
      'Play Again',
      'Review Answer',
      'Share Score',
      'Generate PDF',
      'Home',
      'Leaderboard'
    ];
    return InkWell(
      onTap: () {
        if (index == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return const ReviewAnswer();
          }));
        } else if (index == 0) {
          Navigator.pop(context);
        } else if (index == 3) {
          _generatePdf(context, height, width);
        }
      },
      child: SizedBox(
        height: height * 0.12,
        width: width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.primaries[index],
              radius: 30,
              child: Icon(iconList[index], color: Colors.white),
            ),
            Text(
              textList[index],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomWidget(double height, double width, BuildContext context) {
    return SizedBox(
      height: height * 0.4,
      width: width,
      child: GridView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 0),
          itemBuilder: (_, index) {
            return Align(
              child: _buildSixWidget(height, width, index, context),
            );
          }),
    );
  }

  void _makePdfDesign(
      BuildContext context, double height, List<pdf.Widget> list) {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: false);
    for (int a = 0; a < quizProvider.quesTemplateList.length; a++) {
      list.add(pdf.RichText(
        text: pdf.TextSpan(text: 'Ques ${a + 1} ', children: [
          pdf.TextSpan(text: '${quizProvider.quesTemplateList[a].ques}\n')
        ]),
      ));

      list.add(pdf.RichText(
        text: pdf.TextSpan(
            text: 'Ans :-> ',
            style: const pdf.TextStyle(color: PdfColors.green),
            children: [
              pdf.TextSpan(
                  text: quizProvider.quesTemplateList[a].answer.toString(),
                  style: const pdf.TextStyle(color: PdfColors.black))
            ]),
      ));
      list.add(pdf.SizedBox(height: height * 0.02));
    }
  }

  void _generatePdf(BuildContext context, double height, double width) {
    List<pdf.Widget> list = [];
    _makePdfDesign(context, height, list);
    pdf.Document document = pdf.Document();
    document.addPage(pdf.MultiPage(build: (_) {
      return list;
    }));
    _saveFile(document, context);
  }

  void _saveFile(pdf.Document document, BuildContext context) async {
    Directory? directory = await getExternalStorageDirectory();
    File file = File('${directory!.path}/QuizQuestions.pdf');
    file
        .writeAsBytes(await document.save())
        .then((value) => _showSnackBar(context));
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('pdf Generated Successfully')));
  }
}
