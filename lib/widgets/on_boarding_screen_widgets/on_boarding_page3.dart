import 'package:flutter/material.dart';
import '/widgets/on_boarding_screen_widgets/on_boarding_image.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      children: [
        SizedBox(height: height * 0.05),
        OnBoardingImage(
            firstImageHeight: height * 0.2922,
            secondImageHeight: height * 0.403,
            firstImageWidth: width * 0.7028,
            secondImageWidth: width * 0.5456,
            imageNo: 3,
          firstBottom: 0,
          secondBottom: height * 0.0433,
        ),
        // SizedBox(
        //   height: height * 0.45,
        //   width: width,
        //   // color: Colors.red,
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Positioned(
        //         bottom: 0,
        //         child: SvgPicture.asset(
        //           'assets/images/onboardingbackground3.svg',
        //           // height: 222
        //           height: height * 0.2922,
        //           // width: 253,
        //           width: width * 0.7028,
        //         ),
        //       ),
        //
        // //---------------------
        //       Positioned(
        //           // bottom: 32.9,
        //           bottom: height * 0.0433,
        //           child: SvgPicture.asset(
        //             'assets/images/onboardingimage3.svg',
        //             // height: 306.25,
        //             height: height * 0.403,
        //             width: width * 0.5456,
        //           ))
        //     ],
        //   ),
        // ),
        SizedBox(
          // height: 52.75,
          height: height * 0.0694,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            // height: 88,
            height: height * 0.1158,
            width: width,
            //19
            // color: Colors.greenAccent,
            child: Text(
              'Custom Math problems',
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
          // height: 66,
          height: height * 0.0869,
          width: width * 0.6,
          // color: Colors.red,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
