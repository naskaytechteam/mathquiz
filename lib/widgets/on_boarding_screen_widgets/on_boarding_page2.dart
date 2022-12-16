import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/on_boarding_screen_widgets/skip_button.dart';

class OnBoardingPage2 extends StatelessWidget {
  // final VoidCallback onSkip;

  const OnBoardingPage2({/*required this.onSkip,*/ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      children: [
        SkipButton(),
        SizedBox(
          //height: 23.58
          height: height * 0.031,
        ),
        SizedBox(
          height: height * 0.45,
          width: width,
          // color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/onboardingbackground2.svg',
                  // height: 316
                  // width:280,
                  width: width * 0.778,
                  height: height * 0.4158,
                ),
              ),
              Positioned(
                  // bottom: 32.9,
                  bottom: height * 0.0433,
                  child: SvgPicture.asset(
                    'assets/images/onboardingimage2.svg',
                    // height: 311.52,
                    // width: 182.5,
                    width: width * 0.507,
                    height: height * 0.41,
                  ))
            ],
          ),
        ),
        SizedBox(
            // height: 19,
            height: height * 0.025),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            // height: 88,
            height: height * 0.1158,
            width: width,
            //19
            child: Text(
              'Mockup tests for Olympiad',
              style: TextStyle(
                  // fontSize: 32,
                  fontSize: height * 0.0422,
                  color: const Color.fromRGBO(52, 73, 94, 1),
                  fontWeight: FontWeight.w900,
                  fontFamily:
                      Theme.of(context).textTheme.headline2!.fontFamily),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          // height: 14,
          height: height * 0.01845,
        ),
        SizedBox(
          // height: 88,
          height: height * 0.1158,
          width: width * 0.6,
          // color: Colors.red,
          child: Text(
            'Lorem ipsum dolor  consectetur  sed do eiusmod  ut labore et dolore aliqua.',
            style: TextStyle(
                // fontSize: 16,
                fontSize: height * 0.0211,
                fontWeight: FontWeight.w500,
                fontFamily: Theme.of(context).textTheme.headline2?.fontFamily),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
