import 'dart:io';
import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pdfWidget;
import '../../model/question.dart';

class PdfDesign {
  //should we make this class as SingleTon or static methods are fine
  static Future<String> makePdf(List<Question> questions) async{
    Directory tempPath=await getTemporaryDirectory();
    List<pdfWidget.Widget> pdfWidgetsList = [];
    _makeDesign(questions, pdfWidgetsList);
    pdfWidget.Document document = _getPdfPages(pdfWidgetsList);
    return _savePdf(document, tempPath.path);
  }

  static Future<String> _savePdf(pdfWidget.Document document, String path) async {
    DateTime dateTime = DateTime.now();
    File file = File('$path/${dateTime.millisecondsSinceEpoch}.pdf');
    file=await file.writeAsBytes(await document.save());
    log('pdf has saved successfully');
    return file.path;
  }

  static pdfWidget.Document _getPdfPages(List<pdfWidget.Widget> pdfWidgetsList) {
    pdfWidget.Document document = pdfWidget.Document();
    document.addPage(pdfWidget.MultiPage(build: (_) => pdfWidgetsList));
    return document;
  }

  static void _makeDesign(
      List<Question> questions, List<pdfWidget.Widget> pdfWidgetsList,
     /* [bool isTest = false]*/) {
    for (int i = 0; i < questions.length; i++) {
      pdfWidgetsList.add(pdfWidget.RichText(
        text: pdfWidget.TextSpan(
            text: 'Ques ${i + 1} ',
            children: [pdfWidget.TextSpan(text: '${questions[i].question}\n')]),
      ));

      // if (!isTest) {
        pdfWidgetsList.add(pdfWidget.RichText(
          text: pdfWidget.TextSpan(
              text: 'Ans :-> ',
              style: const pdfWidget.TextStyle(color: pdf.PdfColors.green),
              children: [
                pdfWidget.TextSpan(
                    text: questions[i].answer.toString(),
                    style: const pdfWidget.TextStyle(color: pdf.PdfColors.black))
              ]),
        ));
      // }
    // else {
    //     pdfWidgetsList.add(pdfW.Row(children: [
    //       for (int j = 0; j < questions[i].options.length; j++) ...[
    //         pdfW.Container(
    //             decoration: pdfW.BoxDecoration(border: pdfW.Border.all()),
    //             padding: const pdfW.EdgeInsets.symmetric(horizontal: 5),
    //             child: pdfW.Text(questions[i].options[j].toString())),
    //         pdfW.SizedBox(width: 20)
    //       ]
    //     ]));
      // }

      pdfWidgetsList.add(pdfWidget.SizedBox(height: 7));
    }
  }
}
