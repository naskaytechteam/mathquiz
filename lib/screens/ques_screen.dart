import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '/widgets/common_widgets/custom_button.dart';
import '../widgets/quesscreenswidgets/options.dart';
import '/model/question.dart';
import '/provider/template_factory.dart';

class QuesScreen extends StatefulWidget {
  final TemplateType templateType;
  final List<Question> questions;

  const QuesScreen(
      {required this.templateType, required this.questions, Key? key})
      : super(key: key);

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  static const _noOptionSelectedIndex = -1;
  int _optionSelectedIndex = _noOptionSelectedIndex;
  int _quesIndex = 0;
  bool _isOptionSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    Question question = widget.questions[_quesIndex];
    bool isFirstQuestion = _quesIndex == 0;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(
        title: widget.templateType.name,
        height: height * 0.1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.1112),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // height: 25,
                height: height * 0.033,
              ),
              Container(
                // height: height * 0.18,
                // width: width,
                // height: 102,
                height: height * 0.13422,
                // width: 295,
                width: width * 0.81945,
                child: AutoSizeText(
                  question.question,
                  style: TextStyle(
                      // fontSize: 20,
                      fontSize: height * 0.02632,
                      fontWeight: FontWeight.w600,
                      fontFamily:
                          Theme.of(context).textTheme.headline2?.fontFamily),
                ),
              ),
              SizedBox(
                // height: 40,
                height: height * 0.05264,
              ),
              Options(
                option: widget.questions[_quesIndex].options,
                onOptionSelected: _onOptionSelected,
                optionSelectedIndex: _optionSelectedIndex,
              ),
              _gap(/*90*/ height * 0.11843),
              const Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.black,
              ),
              _gap(/*25*/ height * 0.033),

              SizedBox(
                // height: 80,
                height: height * 0.1053,
                width: width,
                child: Row(
                  mainAxisAlignment: isFirstQuestion
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isFirstQuestion)
                      TextButton(
                        onPressed: _onPreviousButtonClick,
                        child: Text(
                          'PREVIOUS',
                          style: TextStyle(
                              color: const Color.fromRGBO(231, 76, 60, 1),
                              // fontSize: 20,
                              fontSize: height * 0.02632,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.fontFamily,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    CustomButton(
                      buttonName: 'Next',
                      // height: 70,
                      height: height * 0.0922,
                      // width: 130,
                      width: width * 0.36112,
                      onButtonPressed:
                          _isOptionSelected ? _onNextButtonClick : null,
                      backgroundColor: _isOptionSelected
                          ? const Color.fromRGBO(231, 76, 60, 1)
                          : const Color.fromRGBO(236, 240, 241, 1),
                      shadowColor: _isOptionSelected
                          ? const Color.fromRGBO(192, 57, 43, 1)
                          : const Color.fromRGBO(189, 195, 199, 1),
                      // backgroundColor: !checkOptionSelected?Colors.black:Colors.red,
                    )
                  ],
                ),
              ),

              // _gap(height * 0.02),
              /* Image.asset(
                'assets/back.png',
                fit: BoxFit.fill,
                width: width,
                height: height * 0.2,
              ),
              _gap(height * 0.02),
              _buildQuesType(widget.templateType, width, height),
              _gap(height * 0.02),
              CurrentQuesList(
                index: _quesIndex,
                totalQuestion: widget.questions.length,
              ),
              _gap(height * 0.03),
              // BuildQuestion(ques: question.question),
              Options(quesScreen: this, option: question.options),
              _gap(height * 0.03),
              _buildNextButton(height, width)

              */
            ],
          ),
        ),
      ),
      // ),
    );
  }

  // void onGeneratePdf() async {
  //   Directory? directory = await getExternalStorageDirectory();
  //   await PdfDesign.makePdf(widget.questions, directory!.path);
  // }

  // Widget _buildNextButton(double height, double width) {
  //   return InkWell(
  //     onTap: _onNextButtonClick,
  //     child: Container(
  //       height: height * 0.07,
  //       width: width,
  //       decoration: BoxDecoration(
  //           color: Theme.of(context).primaryColor,
  //           borderRadius: BorderRadius.circular(20)),
  //       alignment: Alignment.center,
  //       child: const Text(
  //         'Next',
  //         style: TextStyle(fontSize: 20, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildQuesType(TemplateType quizType, double width, double height) {
  //   return Container(
  //       width: width,
  //       height: height * 0.05,
  //       alignment: Alignment.centerLeft,
  //       child: Text(
  //         quizType.name,
  //         style: const TextStyle(color: Colors.white, fontSize: 20),
  //       ));
  // }

  void _onNextButtonClick() {
    if (_quesIndex < widget.questions.length) {
      _updateScore();
    }
    _increaseIndex();
  }

  void _onPreviousButtonClick() {
    _decreaseIndex();
  }

  void _decreaseIndex() {
    setState(() {
      _quesIndex--;
    });
  }

  void _updateScore() {
    if (_checkAnswer()) {
      _increaseScore();
    }
  }

  void _increaseScore() {
    TemplateFactory templateFactory = TemplateFactory();
    templateFactory.increaseScore();
  }

  void _increaseIndex() {
    if (_quesIndex < widget.questions.length - 1) {
      setState(() {
        _quesIndex++;
      });
      return;
    }
    showScore();
  }

  bool _checkAnswer() {
    num answer = widget.questions[_quesIndex].answer;
    return answer == _optionSelectedIndex;
  }

  void _showScore() {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
    //   return ScoreScreen(
    //     questionNo: _questionNo,
    //     questions: widget.questions,
    //   );
    // }));
    justForTextMethod();
  }

  void showScore() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return ScoreScreen(
        questionNo: _questionNo,
        questions: widget.questions,
      );
    }));
  }

  int get _questionNo {
    return _quesIndex + 1;
  }

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
