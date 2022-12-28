import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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
  static const String _buttonTextNo = 'NO';
  static const String _buttonTextYes = 'YES';

  const ScoreScreen(
      {/*required this.questionNo,*/ required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    // final TemplateFactory templateFactory = TemplateFactory();
    final int correctAnswer = _getTotalCorrectAnswer();
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
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: height * 0.05,
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
              child: SizedBox(
                width: width,
                height: height * 0.033,
                child: Text(
                  'You answered',
                  style: TextStyle(
                    // fontSize: 18,
                    fontSize: height * 0.0237,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
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
                child: SizedBox(
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
                        context,
                        correctAnswer: correctAnswer),
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
    return 'assets/images/score_screen_image$image.svg';
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
      BuildContext context,
      {int? correctAnswer}) {
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
                  _showTryAgainDialog(context, height, width);
                  break;
                case 2:
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return ReviewAnswerScreen(
                      questions: questions,
                      totalCorrectAnswer: correctAnswer!,
                    );
                  }));
                  break;
                case 3:
                  _onPdfButtonClick(context);
                  break;
              }
            },
            backgroundColor: backgroundColor,
            shadowColor: shadowColor,
            shadowHeight: height * 0.0093,
            child: SvgPicture.asset(
              'assets/images/$imageName.svg',
              height: height * 0.044,
            ),
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

  void _showSnackBar(ScaffoldMessengerState state, String text) {
    state.showSnackBar(SnackBar(content: Text(text)));
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

  void _onPdfButtonClick(BuildContext context) async {
    _showProgressBar(context);
    final ScaffoldMessengerState state = ScaffoldMessenger.of(context);
    final NavigatorState navigatorState = Navigator.of(context);
    final String pdfPath = await PdfDesign.makePdf(questions);
    final File file = File(pdfPath);
    const String username = 'testg9889@gmail.com';
    const String password = 'ivbdfxezijtwdlsu';
    // const String accessToken='976763470554-j74n271gjft2pajl62pp07srl5bq19c0.apps.googleusercontent.com';
    // final smtpServer =gmailSaslXoauth2(username, accessToken);
    final smtpServer = gmail(username, password);
    final Message message =
        buildMessage(username, file, 'nikirana1983@gmail.com');
    SendReport? rep;
    try {
      rep = await send(message, smtpServer);
      navigatorState.pop();
      _showSnackBar(state, 'pdf has successfully sent to your parent Email ');
    } on MailerException catch (e) {
      navigatorState.pop();
      _showSnackBar(state, 'error occurred in pdf sending $e');
    }
  }

  void _tryAgainQuiz(BuildContext context) async {
    NavigatorState navigatorState = Navigator.of(context);
    TemplateFactory templateFactory = TemplateFactory();
    _showProgressBar(context);
    TemplateType templateType = templateFactory.currentTemplateType;
    List<Question> questions =
        await templateFactory.generateQuestions(templateType);
    navigatorState.pop();
    if (questions.isNotEmpty) {
      _goToQuesScreen(navigatorState, templateType, questions);
    }
  }

  void _goToQuesScreen(NavigatorState navigatorState, TemplateType templateType,
      List<Question> questions) {
    navigatorState.pushReplacement(MaterialPageRoute(builder: (_) {
      return QuesScreen(templateType: templateType, questions: questions);
    }));
  }

  void _onDialogButtonClick(BuildContext context, String buttonName) {
    if (buttonName == _buttonTextNo) {
      _pop(context);
      return;
    }
    _pop(context);
    _tryAgainQuiz(context);
  }

  void _pop(BuildContext context) {
    NavigatorState navigatorState = Navigator.of(context);
    navigatorState.pop();
  }

  void _showTryAgainDialog(BuildContext context, double height, double width) {
    showDialog(
        context: context,
        builder: (_) {
          return Card(
            color: Colors.white10,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: height * 0.2845,
                width: width * 0.7512,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(height * 0.0352),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.0674,
                      width: width * 0.5755,
                      child: Text(
                        'Are you sure you want to try again?',
                        style: TextStyle(
                          fontSize: height * 0.025,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.09982,
                      width: width * 0.6468,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDialogButton(
                              _buttonTextNo, context, height, width),
                          _buildDialogButton(
                              _buttonTextYes, context, height, width)
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

  Widget _buildDialogButton(
      String buttonText, BuildContext context, double height, double width) {
    return CustomButton(
        buttonName: buttonText,
        height: height * 0.0874,
        width: width * 0.3107,
        backgroundColor: buttonText == _buttonTextYes
            ? const Color.fromRGBO(46, 204, 113, 1)
            : const Color.fromRGBO(231, 76, 60, 1),
        shadowColor: buttonText == _buttonTextYes
            ? const Color.fromRGBO(39, 174, 96, 1)
            : const Color.fromRGBO(192, 57, 43, 1),
        onButtonPressed: () => _onDialogButtonClick(context, buttonText));
  }
}
