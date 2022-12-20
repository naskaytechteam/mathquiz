import 'package:flutter/material.dart';
import '/widgets/on_boarding_screen_widgets/on_boarding_image.dart';
import '/widgets/on_boarding_screen_widgets/skip_button.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Column(
      children: [
        const SkipButton(),
        OnBoardingImage(
            firstImageHeight: height * 0.375,
            secondImageHeight: height * 0.39894,
            firstImageWidth: width * 0.7585,
            secondImageWidth: width * 0.54699,
            imageNo: 1,
          firstBottom: 0,
          secondRight: 0,
            secondLeft: 0,
            secondBottom: height * 0.01555,
        ),
        // SizedBox(
        //   height: height * 0.45,
        //   width: width,
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Positioned(
        //         bottom: 0,
        //         child: SvgPicture.asset(
        //           'assets/images/onboardingbackground1.svg',
        //           // height: 285,
        //           height: height * 0.375,
        //           // width: 273,
        //           width: width * 0.7585,
        //           // fit: BoxFit.fitWidth,
        //         ),
        //       ),
        //
        // // -----------------------------------
        //       Positioned(
        //           // bottom: 11.81,
        //           right: 0,
        //           left: 0,
        //           bottom: height * 0.01555,
        //           child: SvgPicture.asset(
        //             'assets/images/onboardingimage1.svg',
        //             // width: 196.94,
        //             width: width * 0.54699,
        //             // height: 303.19,
        //             height: height * 0.39894,
        //           ))
        //     ],
        //   ),
        // ),
        SizedBox(
          // height: 45,
          height: height * 0.0593,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            // height: 88,
            height: height * 0.1158,
            width: width,
            //19
            child: Text(
              'Learning is fun \nnow',
              style: TextStyle(
                  // fontSize: 32,
                  fontSize: height * 0.04215,
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
          height: height * 0.0185,
        ),
        SizedBox(
          // height: 66,
          height: height * 0.0869,
          width: width * 0.6,
          // color: Colors.red,
          child: Text(
            'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.',
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
