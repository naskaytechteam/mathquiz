import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class Page2 extends StatelessWidget {
  final VoidCallback onSkip;
  const Page2({required this.onSkip,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double height=size.height;
    double width=size.width;
    return Column(
      children: [
        SkipButton(fontSize: height * 0.5),

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
                child: SvgPicture.asset(
                    'assets/images/onboardingbackground2.svg',
                    height: 316
                ),
              ),
              Positioned(
                  bottom: 32.9,
                  child: SvgPicture.asset(
                    'assets/images/onboardingimage2.svg',
                    height: 311.52,
                  ))
            ],
          ),
        ),
        SizedBox(height: 19,),
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
          height: 88,
          width: width * 0.6,
          // color: Colors.red,
          child: Text(
            'Lorem ipsum dolor  consectetur  sed do eiusmod  ut labore et dolore aliqua.',
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
