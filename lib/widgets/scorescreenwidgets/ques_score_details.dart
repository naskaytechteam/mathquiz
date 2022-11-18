import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class QuesScoreDetails extends StatelessWidget {
  final String firstResult;
  final String secondResult;
  final String firstType;
  final String secondType;
  final Color? firstTextColor;
  final Color? secondTextColor;

  const QuesScoreDetails(
      {required this.firstType,
      required this.secondType,
      this.firstTextColor,
      this.secondTextColor,
      required this.firstResult,
      required this.secondResult,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildQuestionScoreDetails(firstResult, firstType, height, width,
              textColor: firstTextColor),
          buildQuestionScoreDetails(secondResult, secondType, height, width,
              textColor: secondTextColor)
        ],
      ),
    );
  }

  Widget buildQuestionScoreDetails(
      String firstDetails, String type, double height, double width,
      {Color? textColor = const Color.fromRGBO(56, 61, 110, 1)}) {
    return Align(
      child: SizedBox(
        height: height * 0.1,
        width: width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(firstDetails,
                style: TextStyle(
                    color: textColor,
                    fontSize: height*0.025,
                    fontWeight: FontWeight.bold)),
            AutoSizeText(type)
          ],
        ),
      ),
    );
  }
}
