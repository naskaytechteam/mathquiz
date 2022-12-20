import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/common_widgets/custom_gridview.dart';
import '../homescreenwidgets/class_screen_widgets/ranking_container.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final String? nunitoFontFamily =
        Theme.of(context).textTheme.headline2?.fontFamily;
    final TextStyle commonTextStyle = TextStyle(
        fontWeight: FontWeight.w900,
        // fontSize: 16,
        fontSize: height * 0.0211,
        fontFamily: nunitoFontFamily);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // height: 59,
          height: height * 0.07764,
        ),
        Padding(
          padding: EdgeInsets.only(left: /*40*/ width * 0.11112),
          child: SizedBox(
            // height: 15,
            height: height * 0.01975,
            width: width,
            child: Text(
              'All Your',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // fontSize: 14,
                  fontSize: height * 0.0185,
                  fontFamily: nunitoFontFamily),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.11112),
          child: SizedBox(
            // height: 44,
            height: height * 0.0579,
            // width: 143,
            width: width * 0.398,
            child: Text('Rankings',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    // fontSize: 32,
                    fontSize: height * 0.04215,
                    fontFamily: nunitoFontFamily)),
          ),
        ),
        SizedBox(
          // height: 43,
          height: height * 0.0566,
        ),
        Padding(
          padding: EdgeInsets.only(left: /*40*/ width * 0.11112),
          child: SizedBox(
            // height: 22,
            height: height * 0.029,
            // color: Colors.red,
            // width: 139,
            width: width * 0.3862,
            child: Text('Summary', style: commonTextStyle),
          ),
        ),
        SizedBox(
          // height: 15,
          height: height * 0.01975,
        ),
        SizedBox(
          // color: Colors.red,
          // height: 192,
          height: height * 0.25264,
          width: width,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.11112),
            scrollDirection: Axis.horizontal,
            children: [
              RankingContainer(
                containerColor: const Color.fromRGBO(241, 196, 15, 1),
                shadowColor: const Color.fromRGBO(243, 156, 18, 1),
                detailName: 'Total Test Given',
                detailNo: '12',
                fontFamily: nunitoFontFamily,
              ),
              RankingContainer(
                containerColor: const Color.fromRGBO(46, 204, 113, 1),
                shadowColor: const Color.fromRGBO(39, 174, 96, 1),
                detailName: 'Lessons Completed',
                detailNo: '57',
                fontFamily: nunitoFontFamily,
              ),
              RankingContainer(
                containerColor: const Color.fromRGBO(52, 152, 219, 1),
                shadowColor: const Color.fromRGBO(41, 128, 185, 1),
                detailName: 'Average Score',
                detailNo: '7/10',
                fontFamily: nunitoFontFamily,
              )
            ],
          ),
        ),
        SizedBox(
          // height: 24,
          height: height * 0.03158,
        ),
        Padding(
          padding: EdgeInsets.only(left: /*40*/ width * 0.11112),
          child: SizedBox(
              // height: 22,
              height: height * 0.029,
              // width: 139,
              width: width * 0.3862,
              child: Text(
                'Scores',
                style: commonTextStyle,
              )),
        ),
        SizedBox(
          // height: 15,
          height: height * 0.01975,
        ),
        CustomGridView(
            totalHeight: height * 0.3079, mainAxisExtent: height * 0.2182),
        SizedBox(
          // height: 30,
          height: height * 0.0395,
        ),
        _buildYouScoredContainer(height, width, nunitoFontFamily)
      ],
    );
  }
  Widget _buildYouScoredContainer(double height,double width,String? fontFamily){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: /* 40*/ width * 0.11112),
      child: SizedBox(
        // height: 198,
        height: height * 0.26055,
        // width: 295,
        width: width * 0.82,
        child: Stack(
          children: [
            Positioned(
              // top:27,
              child: Align(
                child: Container(
                  // height: 162,
                  height: height * 0.2132,
                  // width: 295,
                  width: width * 0.82,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(52, 152, 219, 1),
                      borderRadius:
                      BorderRadius.circular(/*25*/ height * 0.033),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, /*9*/ height * 0.0119),
                            color: const Color.fromRGBO(41, 128, 185, 1))
                      ]),
                ),
              ),
            ),
            Positioned(
              // left: 123,
                left: width * 0.3417,
                // top: 25,
                height: height * 0.033,
                child: SvgPicture.asset('assets/images/book.svg')),
            Positioned(
              // bottom: 32.13,
              bottom: height * 0.04215,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/Elephant.svg',
                // height: 165.87,
                height: height * 0.2182,
                // width: 128.45,
                width: width * 0.3567,
              ),
            ),
            Positioned(
              // top: 40,
                top: height * 0.0527,
                // left: 21,
                left: width * 0.0584,
                child: SizedBox(
                  // height: 15,
                  height: height * 0.01975,
                  // width: 80,
                  width: width * 0.2223,
                  child: Text(
                    'You Scored',
                    style: TextStyle(
                      // fontSize: 14,
                        fontSize: height * 0.0185,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: fontFamily),
                  ),
                )),
            Positioned(
              // left: 21,
                left: width * 0.0584,
                // top: 57,
                top: height * 0.075,
                child: SizedBox(
                  // height: 65,
                  height: height * 0.0856,
                  width: width,
                  child: Text(
                    '9/10',
                    style: TextStyle(
                      // fontSize: 48,
                        fontSize: height * 0.06316,
                        color: const Color.fromRGBO(241, 196, 15, 1),
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily),
                  ),
                )),
            Positioned(
              // top: 113,
                top: height * 0.1487,
                // left: 24,
                left: width * 0.0667,
                child: SizedBox(
                  child: Text(
                    'in your last test',
                    style: TextStyle(
                        color: Colors.white,
                        // fontSize: 12,
                        fontSize: height * 0.0158,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
