import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathquiz/widgets/onboardingscreenwidgets/skip_button.dart';

class OnBoardingPage1 extends StatelessWidget {
  // final VoidCallback onSkip;

  const OnBoardingPage1({/*required this.onSkip,*/ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Column(
      children: [
        Container(
          // color: Colors.yellow,
          height: height * 0.05,
          width: width,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onSkip,
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: const Color.fromRGBO(127, 140, 141, 1),
                  fontSize: height * 0.0225,
                  fontFamily:
                  Theme.of(context).textTheme.headline2!.fontFamily,
                  // fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
        ),
        // SizedBox(height: 27,),
        Container(
          height: height * 0.45,
          width: width,
          // color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: SvgPicture.asset(
                  'assets/images/onboardingbackground1.svg',
                  height: 285,
                  width: 273,
                  fit: BoxFit.fitWidth,

                ),
              ),
              Positioned(
                  bottom: 11.81,
                  child: SvgPicture.asset(
                    'assets/images/onboardingimage1.svg',
                    width: 196.94,
                    height: 303.19,
                  ))
            ],
          ),
        ),
        SizedBox(height: 45,),
        Container(
          height: 88,
          width: width,
          //19
          // color: Colors.greenAccent,
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Text(
            'Mockup tests for Olympiad',
            style: TextStyle(
                fontSize: 32,
                color: const Color.fromRGBO(52, 73, 94, 1),
                fontWeight: FontWeight.w900,
                fontFamily: Theme.of(context).textTheme.headline2!.fontFamily),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          height: 66,
          width: width * 0.6,
          // color: Colors.red,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: Theme.of(context).textTheme.headline2?.fontFamily),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
