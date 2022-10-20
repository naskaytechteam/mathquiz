import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';

class QuesNames extends StatelessWidget {
  final Function(QUESTYPE questype) onQuesTypeSelected;
  final QUESTYPE questype;
  final Color color;

  const QuesNames(
      {required this.onQuesTypeSelected,
        required this.questype,
        required this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return
      InkWell(
      onTap: () => onQuesTypeSelected(questype),
      child: SizedBox(
        height: height * 0.2,
        width: width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
              width: width * 0.25,
              child: Image.asset(
                'assets/simple.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            _buildQuestionName(questype, height, width),
            Container(
              height: height * 0.01,
              width: width * 0.3,
              color: Colors.grey.shade200,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(

                    height: height * 0.01,
                    width: /*widthAnimation.value*/100,
                    color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionName(QUESTYPE quesType, double height, double width) {
    return SizedBox(
      height: height * 0.045,
      width: width,
      child: AutoSizeText(
        quesType.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
