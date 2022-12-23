import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '/provider/template_factory.dart';
import '/screens/ques_screen.dart';
import '/widgets/score_screen_widgets/pdf_design.dart';
import '/screens/review_answer_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '/widgets/common_widgets/custom_button.dart';
import '../model/question.dart';

class ScoreScreen extends StatelessWidget {
  // final int questionNo;
  final List<Question> questions;

  const ScoreScreen(
      {/*required this.questionNo,*/ required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    // final TemplateFactory templateFactory = TemplateFactory();
    final int correctAnswer = _getCorrectAnswer();
    final double answerInPercent = correctAnswer / questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/images/cross.svg',
              // height: 22,
              height: height * 0.029,
              // width: 22,
              width: width * 0.0612,
            ),
          ),
          SizedBox(
            width: width * 0.065,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            // top: 40,
            top: height * 0.053,
            child: Align(
              child: Container(
                  alignment: Alignment.center,
                  // height: 44,
                  height: height * 0.0579,
                  // width: 170,
                  width: width,
                  // width: width * 0.47,
                  // color: Colors.red,
                  child: Text(
                    _getTextAccordingToAnswer(correctAnswer),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            // 32
                            height * 0.04215),
                  )),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                'assets/images/cup.svg',
                // height: 124,
                height: height * 0.1632,
                // width: 112,
                width: width * 0.3112,
              )),
          //todo check scrollbar logic for lcm(small) ques
          Positioned(
              // top: height * 0.14,
              bottom: height * 0.436,
              child: Align(
                child: Container(
                  height: height * 0.35,
                  width: width,
                  // color: Colors.white.withOpacity(0.3),
                  alignment: Alignment.bottomCenter,
                  child: CircularPercentIndicator(
                    // radius: 120,
                    radius: height * 0.158,
                    animation: true,
                    animationDuration: 2000,
                    // lineWidth: 10,
                    lineWidth: height * 0.0132,
                    // percent: answerInPresent,
                    percent: answerInPercent,
                    arcBackgroundColor: const Color.fromRGBO(236, 240, 241, 1),
                    arcType: ArcType.FULL,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.transparent,
                    progressColor: __getProgressAccordingToScore(correctAnswer),
                  ),
                ),
              )),
          Positioned(
              // top: height * 0.25,
              bottom: height * 0.642,
              right: 0,
              left: 0,
              child: Align(
                child: SizedBox(
                  width: width * 0.35,
                  // color: Colors.red,
                  child: Text(
                    'You answered',
                    style: TextStyle(
                      // fontSize: 18,
                      fontSize: height * 0.0237,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
          Positioned(
              // top: height * 0.29,
              bottom: height * 0.536,
              right: 0,
              left: 0,
              child: Align(
                child: SizedBox(
                  width: width * 0.4,
                  height: height * 0.1,
                  child: Text(
                    '$correctAnswer/${questions.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontSize: 64,
                      fontSize: height * 0.0843,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )),
          Positioned(
              // top: height * 0.39,
              bottom: height * 0.486,
              right: 0,
              left: 0,
              child: Align(
                child: Container(
                  width: width * 0.4,
                  height: height * 0.05,
                  child: Text(
                    'questions correctly',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontSize: 14,
                      fontSize: height * 0.0185,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: height * 0.28,
            child: SvgPicture.asset(
              _getImageAccordingToScore(correctAnswer),
              // height: 137,
              height: height * 0.1803,
              // width: 89,
              width: width * 0.2473,
            ),
          ),
          Positioned(
            bottom: height * 0.05,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                // height: 153,
                height: height * 0.2014,
                width: width,
                margin: EdgeInsets.symmetric(horizontal: width * 0.072),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCustomContainer(
                        'Try\n Again',
                        height,
                        width,
                        const Color.fromRGBO(241, 196, 15, 1),
                        const Color.fromRGBO(243, 156, 18, 1),
                        'try_again',
                        1,
                        context),
                    _buildCustomContainer(
                        'Review Answers',
                        height,
                        width,
                        const Color.fromRGBO(52, 152, 219, 1),
                        const Color.fromRGBO(41, 128, 185, 1),
                        'review',
                        2,
                        context),
                    _buildCustomContainer(
                        'Generate PDF',
                        height,
                        width,
                        const Color.fromRGBO(231, 76, 60, 1),
                        const Color.fromRGBO(192, 57, 43, 1),
                        'pdf',
                        3,
                        context),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color __getProgressAccordingToScore(int answer) {
    double value = _getPercentageValue(answer);
    if (value < 41) {
      return Colors.red;
    } else if (value < 71) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  String _getImageAccordingToScore(int answer) {
    int? image;
    double value = _getPercentageValue(answer);
    if (value < 41) {
      image = 1;
    } else if (value < 71) {
      image = 2;
    } else {
      image = 3;
    }
    return 'assets/images/scorescreenimage$image.svg';
  }

  double _getPercentageValue(int answer) {
    return answer / questions.length * 100;
  }

  String _getTextAccordingToAnswer(int answer) {
    double value = _getPercentageValue(answer);
    if (value < 41) {
      return 'We can do Better';
    } else if (value < 71) {
      return 'Nice Try';
    } else {
      return 'Well Done!';
    }
  }

  int _getTotalCorrectAnswer() {
    int answer = 0;
    for (int i = 0; i < questions.length; i++) {
      int selectedIndex = questions[i].selectedOptionIndex!;
      if (questions[i].answer == questions[i].options[selectedIndex]) {
        answer++;
      }
    }
    return answer;
  }

  Widget _buildCustomContainer(
      String buttonText,
      double height,
      double width,
      Color backgroundColor,
      Color shadowColor,
      String imageName,
      int containerNo,
      BuildContext context) {
    return SizedBox(
        height: height * 0.2014,
        // width: 93,
        width: width * 0.2584,
        child: Column(children: [
          CustomButton(
            height: height * 0.125,
            // width: 93,
            width: width * 0.2584,
            onButtonPressed: () {
              switch (containerNo) {
                case 1:
                  Navigator.pop(context);
                  break;
                case 2:
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return ReviewAnswerScreen(questions: questions);
                  }));
                  break;
                case 3:
                  _sendPdfToParentEmail(context);
                  break;
              }
            },
            backgroundColor: backgroundColor,
            shadowColor: shadowColor,
            shadowHeight: height * 0.0093,
            child: SvgPicture.asset('assets/images/$imageName.svg'),
          ),
          SizedBox(height: height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            // color: Colors.red,
            width: width,
            height: height * 0.05,
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: height * 0.018, fontWeight: FontWeight.w700),
            ),
          ),
        ]));
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  Message buildMessage(String username, File file, String parentEmail) {
    return Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(parentEmail)
      ..subject = 'enter subject'
      ..text = 'enter text'
      ..attachments = [FileAttachment(file)];
  }

  void _sendPdfToParentEmail(BuildContext context) async {
    _showProgressBar(context);
    String pdfPath = await PdfDesign.makePdf(questions);
    File file = File(pdfPath);
    String username = 'email';
    String password = 'email-pass';
    final smtpServer = gmail(username, password);
    Message message = buildMessage(username, file, 'parentEmail');

    try {
      await send(message, smtpServer);
      Navigator.of(context).pop();
      _showSnackBar(context, 'pdf has successfully sent to your parent Email ');
    } on MailerException catch (e) {
      _showSnackBar(context, 'error occured in pdf sending $e');
    }
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
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 54,
                      width: 226,
                      child: Text(
                        'Are you sure you want to try again?',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
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

// void _goToHomePage(BuildContext context) {
//   TemplateFactory().resetScore();
//   Navigator.pop(context);
// }
}
