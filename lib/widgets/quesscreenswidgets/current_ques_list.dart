import 'package:flutter/material.dart';

class CurrentQuesList extends StatelessWidget {
  final int totalQuestion;
  final int index;

  const CurrentQuesList(
      {required this.index, required this.totalQuestion, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return SizedBox(
      height: height * 0.08,
      width: width,
      child: ListView.builder(
          itemCount: totalQuestion,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            int questionNumber = index + 1;
            return questionNo(questionNumber, height, width);
          }),
    );
  }

  Widget questionNo(int quesNo, double height, double width) {
    int questionNumber = quesNo - 1;
    return Align(
        child: Container(
      height: height * 0.06,
      width: width * 0.13,
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(56, 61, 110, 1),
          borderRadius: BorderRadius.circular(28),
          gradient: index == questionNumber
              ? const LinearGradient(colors: [
                  Color.fromRGBO(227, 90, 158, 1),
                  Color.fromRGBO(190, 106, 228, 1),
                ])
              : null),
      alignment: Alignment.center,
      child: Text(
        '$quesNo',
        style: const TextStyle(fontSize: 25, color: Colors.white),
      ),
    ));
  }
}
