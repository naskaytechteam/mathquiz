import 'dart:io';
import 'dart:developer';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import '../model/question.dart';

class PdfDesign {
  //should we make this class as SingleTon or static methods are fine
  static Future<String> makePdf(List<Question> questions, String path) {
    List<pdf.Widget> pdfWidgetsList = [];
    _makeDesign(questions, pdfWidgetsList);
    pdf.Document document = _getPdfPages(pdfWidgetsList);
    return _savePdf(document, path);
  }

  static Future<String> _savePdf(pdf.Document document, String path) async {
    DateTime dateTime = DateTime.now();
    File file = File('$path/${dateTime.millisecondsSinceEpoch}.pdf');
    file=await file.writeAsBytes(await document.save());
    log('pdf has saved successfully');
    return file.path;
  }

  static pdf.Document _getPdfPages(List<pdf.Widget> pdfWidgetsList) {
    pdf.Document document = pdf.Document();
    document.addPage(pdf.MultiPage(build: (_) => pdfWidgetsList));
    return document;
  }

  static void _makeDesign(
      List<Question> questions, List<pdf.Widget> pdfWidgetsList,
      [bool isTest = false]) {
    for (int i = 0; i < questions.length; i++) {
      pdfWidgetsList.add(pdf.RichText(
        text: pdf.TextSpan(
            text: 'Ques ${i + 1} ',
            children: [pdf.TextSpan(text: '${questions[i].question}\n')]),
      ));

      if (!isTest) {
        pdfWidgetsList.add(pdf.RichText(
          text: pdf.TextSpan(
              text: 'Ans :-> ',
              style: const pdf.TextStyle(color: PdfColors.green),
              children: [
                pdf.TextSpan(
                    text: questions[i].answer.toString(),
                    style: const pdf.TextStyle(color: PdfColors.black))
              ]),
        ));
      } else {
        pdfWidgetsList.add(pdf.Row(children: [
          for (int j = 0; j < questions[i].options.length; j++) ...[
            pdf.Container(
                decoration: pdf.BoxDecoration(border: pdf.Border.all()),
                padding: const pdf.EdgeInsets.symmetric(horizontal: 5),
                child: pdf.Text(questions[i].options[j].toString())),
            pdf.SizedBox(width: 20)
          ]
        ]));
      }

      pdfWidgetsList.add(pdf.SizedBox(height: 7));
    }
  }
}
