import 'package:flutter/material.dart';
import '../model/question_template.dart';
import '/widgets/custom_button.dart';

class Options extends StatelessWidget {
  final Function(num option,num answer) onOptionSelected;
  final QuestionTemplate quizData;

  const Options(
      {required this.onOptionSelected, required this.quizData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return SizedBox(
      height: height * 0.2,
      child: GridView.builder(
          itemCount: 4,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              mainAxisExtent: 70),
          itemBuilder: (_, index) {
            List<String> list = ['1', '2', '3', '4'];
            return CustomButton(
              quesTemp: quizData,
                optionType: list[index],
                onOptionSelected: onOptionSelected,
                option: quizData.options[index]);
          }),
    );
  }
}
