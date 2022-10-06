import 'package:flutter/material.dart';

import '../model/question_template.dart';

class CustomButton extends StatelessWidget {
  final String optionType;
  final num option;
  final Function optionSelected;
  final QuestionTemplate quesTemp;


  const CustomButton(
      {required this.optionType,
      required this.optionSelected,
      required this.option,
        required this.quesTemp,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return InkWell(
      onTap: ()=>optionSelected(option,quesTemp.answer),
      child: Align(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          height: height * 0.06,
          width: width * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade200, width: 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.04,
                width: width * 0.08,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(19)),
                child: Text(
                  optionType,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.2,
                height: height * 0.05,
                child: Text(
                  option.toString(),
                  style:const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
