import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingImage extends StatelessWidget {
  final int imageNo;
  final double firstImageHeight;
  final double secondImageHeight;
  final double firstImageWidth;
  final double secondImageWidth;


  final double? firstBottom;
  final double? firstRight;
  final double? firstLeft;

  final double? secondBottom;
  final double? secondRight;
  final double? secondLeft;

  const OnBoardingImage(
      {
        required this.firstImageHeight,
        required this.secondImageHeight,
        required this.firstImageWidth,
        required this.secondImageWidth,
        required this.imageNo,
      this.firstBottom,
      this.firstRight,
      this.firstLeft,

      this.secondBottom,
      this.secondLeft,
      this.secondRight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double height=size.height;
    double width=size.width;
    return SizedBox(
      height: height * 0.45,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: firstBottom,
            left: firstLeft,
            right: firstRight,
            child: SvgPicture.asset(
              'assets/images/onboardingbackground$imageNo.svg',
              height: firstImageHeight,
              width: firstImageWidth,
            ),
          ),
          Positioned(
              right: secondRight,
              left: secondLeft,
              bottom: secondBottom,
              child: SvgPicture.asset(
                'assets/images/onboardingimage$imageNo.svg',
                width: secondImageWidth,
                height: secondImageHeight,
              ))
        ],
      ),
    );
  }
}
