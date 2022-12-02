import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double height=size.height;
    double width=size.width;
    return Column(
      children: [
        SizedBox(height: height*0.05),
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
                    'assets/images/onboardingbackground3.svg',
                    height: 222
                ),
              ),
              Positioned(
                  bottom: 32.9,
                  child: SvgPicture.asset(
                    'assets/images/onboardingimage3.svg',
                    height: 306.25,
                  ))
            ],
          ),
        ),
        SizedBox(height: 52.75,),
        Container(
          height: 88,
          width: width,
          //19
          // color: Colors.greenAccent,
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Text(
            'Custom Math problems',
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
