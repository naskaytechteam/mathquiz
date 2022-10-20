import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';
import 'package:provider/provider.dart';

class YourPoint extends StatelessWidget {
  const YourPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: false);
    int points=quizProvider.score*15;
    return Align(
      child: Container(
        height: height * 0.3,
        width: width * 0.6,
        decoration: BoxDecoration(
            color: Colors.white70.withOpacity(0.1),
            borderRadius: BorderRadius.circular(120)),
        child: Align(
          child: Container(
            height: height * 0.23,
            width: width * 0.47,
            decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(90)),
            child: Align(
              child: Container(
                  height: height * 0.2,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80)),
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                        text: 'Your Score \n',
                        style: const TextStyle(fontSize: 20),
                        children: [
                          TextSpan(
                              text: points.toString(),
                              style: const TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.w900)),
                          const TextSpan(
                              text: 'pt',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900))
                        ]),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
