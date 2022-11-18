import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BuildQuestion extends StatelessWidget {
  final String ques;

  const BuildQuestion({required this.ques, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      height: height * 0.18,
      width: width,
      child: AutoSizeText(
        ques,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
