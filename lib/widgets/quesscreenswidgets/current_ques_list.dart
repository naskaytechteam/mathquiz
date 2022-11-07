import 'package:flutter/material.dart';

class CurrentQuesList extends StatelessWidget {
  final int totalQuestion;
  final int index;
  final bool isReviewScreen;
  final Function(int index)? onCurrentQuesChange;

  const CurrentQuesList(
      {this.isReviewScreen = false,
      this.onCurrentQuesChange,
      required this.index,
      required this.totalQuestion,
      Key? key})
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
            return questionNo(questionNumber, height, width, context);
          }),
    );
  }

  Widget questionNo(
      int quesNo, double height, double width, BuildContext context) {
    int index = quesNo - 1;
    return Align(
      child: Container(
        height: height * 0.06,
        width: width * 0.13,
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(28),
            gradient: this.index == index
                ? LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ])
                : null),
        alignment: Alignment.center,
        child: InkWell(
          onTap: isReviewScreen ? () => onCurrentQuesChange!(index) : null,
          child: Text(
            '$quesNo',
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
