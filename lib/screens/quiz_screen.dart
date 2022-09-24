import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/widgets/option_button.dart';
import 'package:mathquiz/widgets/quiz_screen_app_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            const QuizScreenAppBar(),
            SizedBox(
              height: height * 0.06,
            ),
            const Text('Question 4'),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.15,
              width: width,
              child: const AutoSizeText(
                ' A car travelled east of Delhi by 44 km and A'
                    ' car travelled east of Delhi by'
                    ' 44 km and of Delhi by 44 km and',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Image.asset('assets/background1.png',
                      width: width, fit: BoxFit.fitHeight)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            twoOption('A', 'B', 'First', 'Second', height, width),
            twoOption('C', 'D', 'Third', 'Forth', height, width)
          ],
        ),
      ),
    );
  }

  Widget twoOption(String firstOptionType, String secondOptionType,
      String firstOption, String secondOption, double height, double width) {
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OptionButton(
            optionType: firstOptionType,
            option: firstOption,
          ),
          OptionButton(optionType: secondOptionType, option: secondOption)
        ],
      ),
    );
  }
}
