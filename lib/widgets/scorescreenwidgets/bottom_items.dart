import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mathquiz/widgets/scorescreenwidgets/review_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
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
              padding: const EdgeInsets.only(top: 20),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 0),
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
        height: height * 0.12,
        width: width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.primaries[index],
              radius: 30,
              child: Icon(_getIconData(index), color: Colors.white),
            ),
            Text(
              _getItemName(index),
            )
          ],
        ),
      ),
    );
  }

  void _onItemSelected(
      double height, double width, int index, BuildContext context) {
    if (index == 0) {
      goToHomePage(context);
    } else if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ReviewAnswer(
          questions: questions,
        );
      }));
    } else if (index == 3) {
      _generatePdf(context, height, width);
    }
  }


  void _generatePdf(BuildContext context, double height, double width) {
    List<pdf.Widget> list = [];
    _makePdfDesign(context, height, list);
    pdf.Document document = pdf.Document();
    document.addPage(pdf.MultiPage(build: (_) => list));
    _saveFile(document, context);
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

  void _saveFile(pdf.Document document, BuildContext context) async {
   // Directory? directory = await getExternalStorageDirectory();
    Directory directory=await getTemporaryDirectory();

    File file = File('${directory.path}/QuizQuestions.pdf');

    // file.writeAsBytes(await document.save())
    //Check how to open a storage path from file explorer via code.
    //     .then((value) => _showSnackBar(context));

    await file.writeAsBytes(await document.save());

    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return ReviewPDF(pdfPath: file.path);
    }));
  }

  // void _showSnackBar(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('pdf Generated Successfully')));
  // }

  void _makePdfDesign(
      BuildContext context, double height, List<pdf.Widget> list) {
    for (int a = 0; a < questions.length; a++) {
      list.add(pdf.RichText(
        text: pdf.TextSpan(
            text: 'Ques ${a + 1} ',
            children: [pdf.TextSpan(text: '${questions[a].question}\n')]),
      ));

      list.add(pdf.RichText(
        text: pdf.TextSpan(
            text: 'Ans :-> ',
            style: const pdf.TextStyle(color: PdfColors.green),
            children: [
              pdf.TextSpan(
                  text: questions[a].answer.toString(),
                  style: const pdf.TextStyle(color: PdfColors.black))
            ]),
      ));
      list.add(pdf.SizedBox(height: height * 0.02));
    }
  }
}
