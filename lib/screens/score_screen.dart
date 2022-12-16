import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/review_answer_screen.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/provider/template_factory.dart';
import '../model/question.dart';

class ScoreScreen extends StatelessWidget {
  final int questionNo;
  final List<Question> questions;

  const ScoreScreen(
      {required this.questionNo, required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    //19
    print('width ${height * 0.025}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          SvgPicture.asset(
            'assets/images/cross.svg',
            height: 22,
            width: 22,
          ),
          SizedBox(
            width: 23,
          ),
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   height: 500,
          //   width: width,
          //   color: Colors.red,
          //   child: Stack(
          //     children: [
          //       Positioned(
          //         right: 0,
          //         left: 0,
          //         top: 40,
          //         child: Align(
          //           child: Container(
          //               // height: 44,
          //               height: height * 0.0579,
          //               // width: 170,
          //               width: width * 0.47,
          //               color: Colors.red,
          //               child: Text(
          //                 'Well Done!',
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w700,
          //                     fontFamily: Theme.of(context)
          //                         .textTheme
          //                         .headline2
          //                         ?.fontFamily,
          //                     fontSize:
          //                         // 32
          //                         height * 0.04215),
          //               )),
          //         ),
          //       ),
          //       Positioned(
          //           top: 0,
          //           left: 0,
          //           child: SvgPicture.asset(
          //             'assets/images/cup.svg',
          //             height: 124,
          //             width: 112,
          //           )),
          //
          //     ],
          //   ),
          // ),

        ],
      ),
    );
  }

  Widget _buildScoreButton(BuildContext context, Color backgroundColor,
      Color shadowColor, int buttonIndex, double height, double width) {
    const List<String> buttonNames = [
      'Try Again',
      'Review Answers',
      'Generate PDF'
    ];
    const List<String> iconsName = ['try_again', 'review', 'pdf'];

    return Container(
      height: 155,
      // height: height * 0.20132,
      // width: 93,
      // color: Colors.yellow,
      width: width * 0.25834,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            // isScoreScreenButton: true,
            // height: 95,
            height: height * 0.125,
            // width: 93,
            width: width * 0.25834,
            onButtonPressed: () {
              if (buttonIndex == 0) {
                showTryAgainDialog(context);
              } else if (buttonIndex == 1) {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  // return ReviewAnswerScreen(
                  //   questions: questions,
                  // );
                // }));
              } else if (buttonIndex == 3) {}
            },
            backgroundColor: backgroundColor,
            shadowColor: shadowColor,
            child:
                SvgPicture.asset('assets/images/${iconsName[buttonIndex]}.svg'),
          ),
          SizedBox(
            // height: 20,
            height: height * 0.0264,
          ),
          Container(
            height: 38,
            // alignment: Alignment.centerRight,
            width: 55,
            child: Text(
              buttonNames[buttonIndex],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                fontWeight: FontWeight.w700,
                // fontSize: 14
                fontSize: height * 0.0185,
              ),
            ),
          )
        ],
      ),
    );
  }

  void showTryAgainDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Card(
            // height: 228,
            // width: 295,
            color: Colors.white10,
            // alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 228,
                width: 295,
                decoration: BoxDecoration(
                  // color: Colors.yellow,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 54,
                      width: 226,
                      child: Text(
                        'Are you sure you want to try again?',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.fontFamily),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // SizedBox(height: 39,),
                    Container(
                      height: 80,
                      width: 254,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              buttonName: 'NO',
                              height: 70,
                              width: 122,
                              onButtonPressed: () {
                                Navigator.of(context).pop();
                              }),
                          CustomButton(
                            buttonName: 'YES',
                            height: 70,
                            width: 122,
                            onButtonPressed: () {},
                            backgroundColor:
                                const Color.fromRGBO(46, 204, 113, 1),
                            shadowColor: const Color.fromRGBO(39, 174, 96, 1),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _goToHomePage(BuildContext context) {
    TemplateFactory().resetScore();
    Navigator.pop(context);
  }
}
/*
Stack(
        children: [
          Positioned(
              // right: 23,
            right: width*0.0639,
              // top: 25,
              top: height * 0.033,
              child: SvgPicture.asset('assets/images/cross.svg',height: 22,width: 22,)),
          Positioned(
            // top: 119,
            top: height*0.15658,
            left: 0,
            right: 0,
            child: Align(
              child:
              ),
            ),
          ),
          Positioned(
            // top: 136,
            top: height*0.17895,
            child: Container(
              height: 373,
              width: 373,
              // color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // height: 19,
                    height: height*0.025,
                    // width: 115,
                    child: Text(
                      'You answered',
                      style: TextStyle(
                          // fontSize: 18,
                        fontSize: height*0.025,
                          fontWeight: FontWeight.w600,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.fontFamily),
                    ),
                  ),
                  SizedBox(
                    // height: 15,
                    height: height * 0.01975,
                  ),
                  Container(
                    height: 69,
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      '9/10',
                      style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.headline2?.fontFamily,
                          fontWeight: FontWeight.w800,
                          fontSize: 64),
                    ),
                  ),
                  Container(
                    // height: 15,
                    height: height * 0.01975,
                    width: 121,
                    child: Text(
                      'questions correctly',
                      style: TextStyle(
                          // fontSize: 14,
                        fontSize:  height * 0.0185,
                          fontWeight: FontWeight.w600,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.fontFamily),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              // top: 411,
              bottom: 223,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/onboardingimage1.svg',
                height: 137.1,
                width: 89,
              )),
          Positioned(
            bottom: 38,
            child: Container(
              // color: Colors.green,
              height: 155,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildScoreButton(
                      context,
                      const Color.fromRGBO(241, 196, 15, 1),
                      const Color.fromRGBO(243, 156, 18, 1),
                      0,
                      height,
                      width),
                  _buildScoreButton(
                      context,
                      const Color.fromRGBO(52, 152, 219, 1),
                      const Color.fromRGBO(41, 128, 185, 1),
                      1,
                      height,
                      width),
                  _buildScoreButton(
                      context,
                      const Color.fromRGBO(231, 76, 60, 1),
                      const Color.fromRGBO(192, 57, 43, 1),
                      2,
                      height,
                      width),
                ],
              ),
            ),
          )
        ],
      )
 */
