import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';
import 'package:mathquiz/widgets/questypesscreenwidgets/custom_animation.dart';

class QuesNames extends StatefulWidget {
  final Function(QUESTYPE questype) onQuesTypeSelected;

  const QuesNames({required this.onQuesTypeSelected, Key? key})
      : super(key: key);

  @override
  State<QuesNames> createState() => _QuesNamesState();
}

class _QuesNamesState extends State<QuesNames>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> widthAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    widthAnimation = Tween<double>(begin: 0, end: 100).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {

          int randomValueForColor = random.nextInt(Colors.primaries.length);

          return CustomAnimation(
              addTime: 800 * index,
              child: _buildQuestionTypeItem(height, width, index,
                  Colors.primaries[randomValueForColor], QUESTYPE.values[index]));
        },
      ),
    );
  }

  Widget _buildQuestionTypeItem(
      double height, double width, int index, Color color, QUESTYPE questype) {
    animationController.forward();
    return InkWell(
      onTap: () => widget.onQuesTypeSelected(questype),
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
                    width: widthAnimation.value,
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
