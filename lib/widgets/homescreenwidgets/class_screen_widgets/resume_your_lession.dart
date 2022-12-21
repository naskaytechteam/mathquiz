import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResumeYourLesson extends StatelessWidget {
  const ResumeYourLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      height: height * 0.1737,
      width: width * 0.8195,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(52, 152, 219, 1),
          borderRadius: BorderRadius.circular(height * 0.033),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, height * 0.0093),
                color: const Color.fromRGBO(41, 128, 185, 1)),
          ]),
      child: Stack(
        children: [
          Positioned(
            left: width * 0.05556,
            top: height * 0.029,
            child: SizedBox(
              height: height * 0.04343,
              width: width * 0.4889,
              child: Text(
                'Let’s Continue',
                style: TextStyle(
                    fontSize: height * 0.03158,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromRGBO(241, 196, 15, 1)),
              ),
            ),
          ),
          Positioned(
            left: width * 0.053,
            top: height * 0.08422,
            child: SizedBox(
              height: height * 0.0579,
              width: width * 0.4278,
              child: Text(
                'Resume your lesson on Geometry',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.0211,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            right: width * 0.07223,
            top: height * 0.1087,
            child: SvgPicture.asset(
              'assets/images/keyboard_arrow_right.svg',
              height: height * 0.026,
              width: width * 0.0314,
            ),
          ),
          Positioned(
              left: width * 0.09167,
              top: height * 0.0211,
              child: SizedBox(
                  height: height * 0.1329,
                  width: width * 0.663,
                  child: SvgPicture.asset('assets/images/arrow.svg')))
        ],
      ),
    );
  }
}
