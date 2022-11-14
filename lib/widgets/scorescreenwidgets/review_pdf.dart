import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class ReviewPDF extends StatelessWidget {
  final String pdfPath;
  const ReviewPDF({
    required this.pdfPath,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double height=size.height;
    double width=size.width;
    return Column(
      children: [
        SizedBox(
          width: width,
            height: height*0.5,
          child: PDFView(
            filePath: pdfPath,
            fitPolicy: FitPolicy.BOTH,
          ),
        ),
        Container(width: width,height: height*0.5,
        color: Colors.red,)
      ],
    );
  }
}
