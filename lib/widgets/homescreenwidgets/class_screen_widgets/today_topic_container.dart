import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class TodayTopicContainer extends StatelessWidget {
  const TodayTopicContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    String? nunitoFamily=Theme.of(context).textTheme.headline2?.fontFamily;


    return Container(
      height: height * 0.24869,
      width: width * 0.81945,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              height * 0.033),
          color: const Color.fromRGBO(26, 188, 156, 1),
          boxShadow: [
            BoxShadow(
                offset: Offset(
                    0,
                    height * 0.0119),
                color: const Color.fromRGBO(22, 160, 133, 1))
          ]),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(
                'assets/images/pig.svg',
                height: height * 0.22237,
                width: width * 0.36945,
              )),
          Positioned(
              top: height * 0.033,
              left: width * 0.053,
              child: SvgPicture.asset(
                'assets/images/book.svg',
                height: height * 0.0758,
                width: width * 0.187,
              )),
          Positioned(
            left: width * 0.05,
            top: height * 0.10922,
            child: SizedBox(
                height: height * 0.029,
                width: width * 0.35001,
                child: Text(
                  'Today’s Topic',
                  style: TextStyle(
                      fontSize: height * 0.0211,
                      fontWeight: FontWeight.w700,
                      fontFamily:
                      nunitoFamily),
                )),
          ),
          Positioned(
            top: height * 0.13816,
            left: width * 0.05556,
            child: SizedBox(
              height: height * 0.0869,
              width: width * 0.4889,
              child: Text(
                'Probability \nTheory',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily:nunitoFamily
                    ,
                    // fontSize: 24,
                    fontSize: height * 0.03158,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Positioned(
              left: width * 0.33612,
              bottom: height * 0.0139,
              child: SvgPicture.asset(
                'assets/images/star.svg',
                height: height * 0.0336,
                width: width * 0.075,
              ))
        ],
      ),
    );
  }
}
