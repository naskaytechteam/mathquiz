import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/on_boarding_screen_widgets/skip_button.dart';

class OnBoardingPage extends StatelessWidget {
  final int imageNo;
  final String firstText;
  final String secondText;
  final bool isSecondPage;
  final double firstGapHeight;
  final double secondTextContainerHeight;
  final bool isThirdScreen;

  const OnBoardingPage(
      {required this.imageNo,
      required this.secondTextContainerHeight,
      required this.firstText,
      this.isSecondPage = false,
      this.isThirdScreen = false,
      required this.firstGapHeight,
      required this.secondText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      children: [
        isThirdScreen ? SizedBox(height: height * 0.05) : const SkipButton(),
        if (isSecondPage)
          SizedBox(
            height :height *0.03
          ),
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            width: width,
            child: SvgPicture.asset(
              'assets/images/on_boarding_image$imageNo.svg',
              // height: imageHeight,
              // width: imageWidth,
            ),
          ),
        ),
        SizedBox(
            // height: 45,
            height: firstGapHeight),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            // height: 88,
            height: height * 0.1158,
            width: width,
            //19
            child: Text(
              firstText,
              style: TextStyle(
                  // fontSize: 32,
                  fontSize: height * 0.0422,
                  color: const Color.fromRGBO(52, 73, 94, 1),
                  fontWeight: FontWeight.w900),
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
          height: secondTextContainerHeight,
          width: width * 0.6,
          // color: Colors.red,
          child: Text(
            secondText,
            style: TextStyle(
              // fontSize: 16,
              fontSize: height * 0.0211,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
