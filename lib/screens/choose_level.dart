import 'package:flutter/material.dart';
import '/widgets/custom_back_buton.dart';
import '../widgets/level_button.dart';

enum LEVEL { easy, medium, hard }

class ChooseLevel extends StatefulWidget {
  const ChooseLevel({Key? key}) : super(key: key);

  @override
  State<ChooseLevel> createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  LEVEL? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            const CustomBackButton(),
            Container(
              height: height * 0.1,
              width: width,
              alignment: Alignment.center,
              child: const Text(
                'Sport',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            raceImage(height, width),
            SizedBox(
              height: height * 0.03,
            ),
            SizedBox(
              width: width,
              child: const Text(
                'Choose your level',
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            OptionButton(
              buttonText: 'Easy',
              buttonClick: () => selectLevel(LEVEL.easy),
              isSelected: _selectedLevel == LEVEL.easy ? true : false,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            OptionButton(
              buttonText: 'Medium',
              isSelected: _selectedLevel == LEVEL.medium ? true : false,
              buttonClick: () => selectLevel(LEVEL.medium),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            OptionButton(
              buttonText: 'Hard',
              isSelected: _selectedLevel == LEVEL.hard ? true : false,
              buttonClick: () => selectLevel(LEVEL.hard),
            )
          ],
        ),
      ),
    );
  }

  Widget raceImage(double height, double width) {
    return SizedBox(
      width: width,
      height: height * 0.35,
      child: Image.asset(
        'assets/race.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  void selectLevel(LEVEL level) {
    setState(() {
      _selectedLevel = level;
    });
  }
}
