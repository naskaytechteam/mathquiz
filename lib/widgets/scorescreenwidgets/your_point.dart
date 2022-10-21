import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';
import 'package:mathquiz/widgets/scorescreenwidgets/ripple_effect_painter.dart';
import 'package:mathquiz/widgets/scorescreenwidgets/score_container.dart';
import 'package:provider/provider.dart';

class YourPoint extends StatefulWidget {
  const YourPoint({Key? key}) : super(key: key);

  @override
  State<YourPoint> createState() => _YourPointState();
}

class _YourPointState extends State<YourPoint>
    with SingleTickerProviderStateMixin {
  int points = 0;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    scaleAnimation = Tween<double>(begin: 20, end: 110).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate));
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startCountingPoints();
    });
    super.initState();
  }

  void _startCountingPoints() async {
    QuizProvider quizProvider =
    Provider.of<QuizProvider>(context, listen: false);
    int points = quizProvider.score * 15;
    if (points > 0) {
      for (int a = 1; a <= points; a++) {
        setState(() {
          this.points = a;
        });
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }
    animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double height = size.height;
    double width = size.width;
    // QuizProvider quizProvider =
    //     Provider.of<QuizProvider>(context, listen: false);
    // int points=quizProvider.score*15;
    return Positioned(
        left: 0,
        right: 0,
        child: SizedBox(
          height: height * 0.39,
          width: width,
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //       height: height * 0.3,
              //       width: width * 0.6,
              //       margin: EdgeInsets.symmetric(horizontal: width * 0.2),
              //       decoration: BoxDecoration(
              //           color: Colors.white70.withOpacity(0.1),
              //           borderRadius: BorderRadius.circular(120))),
              // )
              rippleEffectContainer(height, width),

              rippleEffectContainer(height, width, child: CustomPaint(
                painter: RippleEffectPainter(scaleAnimation.value),),),
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     height: height * 0.3,
              //     width: width * 0.6,
              //     margin: EdgeInsets.symmetric(horizontal: width * 0.2),
              //     decoration: BoxDecoration(
              //         color: Colors.white70.withOpacity(0.1),
              //         borderRadius: BorderRadius.circular(120)),
              //     child: CustomPaint(
              //       painter: RippleEffectPainter(scaleAnimation.value),
              //     ),
              //   ),
              // ),
              ScoreContainer(point: points)
            ],
          ),
        ));
  }

  Widget rippleEffectContainer(double height, double width, {Widget? child}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          height: height * 0.3,
          width: width * 0.6,
          margin: EdgeInsets.symmetric(horizontal: width * 0.2),
          decoration: BoxDecoration(
              color: Colors.white70.withOpacity(0.1),
              borderRadius: BorderRadius.circular(120)),
          child: child),
    );
  }
}
