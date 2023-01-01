import 'dart:io';

import 'package:flutter/material.dart';
import '/screens/score_screen.dart';
import '/widgets/common_widgets/custom_divider.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '/widgets/common_widgets/custom_button.dart';
import '../widgets/quesscreenswidgets/options.dart';
import '/model/question.dart';
import '/provider/template_factory.dart';

class QuesScreen extends StatefulWidget {
  final TemplateType templateType;
  final List<Question> questions;
  final int? quesIndex;

  const QuesScreen(
      {required this.templateType,
      required this.questions,
      this.quesIndex,
      Key? key})
      : super(key: key);

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> /*with WidgetsBindingObserver */{
  static const _noOptionSelectedIndex = -1;
  late int _quesIndex = widget.quesIndex ?? 0;
  late int _optionSelectedIndex =
      widget.questions[_quesIndex].selectedOptionIndex ??
          _noOptionSelectedIndex;

  late bool _isOptionSelected =
      widget.questions[_quesIndex].selectedOptionIndex != null;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   TemplateFactory factory = TemplateFactory();
  //   if (AppLifecycleState.paused == state) {
  //     await factory.saveQuizData(_quesIndex, widget.questions);
  //   } else if (AppLifecycleState.resumed == state) {
  //     factory.deleteSavedData();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final Question question = widget.questions[_quesIndex];
    final bool isFirstQuestion = _quesIndex == 0;
    final bool isLastQuestion = _quesIndex == widget.questions.length - 1;

    return Scaffold(
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
              _gap(height * 0.033),
              Align(
                child: SizedBox(
                  // height: height*0.67,
                  height:Platform.isIOS?height*0.6: height*0.67,
                  width: width,
                  child: SingleChildScrollView(
                    physics:const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.81945,
                          child: Text(
                            question.question,
                            style: TextStyle(
                              // fontSize: 20,
                              fontSize: height * 0.02632,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _gap(height * 0.02),
                        Options(
                          option: widget.questions[_quesIndex].options,
                          onOptionSelected: _onOptionSelected,
                          optionSelectedIndex: _optionSelectedIndex,
                        ),
                        _gap(height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
              _gap(height*0.02),
              const CustomDivider(),
              _gap(height * 0.033),
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
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    CustomButton(
                      buttonName: isLastQuestion ? 'FINISH' : 'NEXT',
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
            ],
          ),
        ),
      ),
      // ),
    );
  }

  void _onOptionSelected(int index) {
    _setSelectedOptionIndex(index);
    setState(() {
      _optionHasSelected(index: index);
    });
  }

  void _setSelectedOptionIndex(int index) {
    widget.questions[_quesIndex].setSelectedOptionIndex = index;
  }

  bool _isNextQuestionOptionSelected() {
    return widget.questions[_quesIndex].selectedOptionIndex == null;
  }

  void _onNextButtonClick() {
    // _setSelectedOptionIndex();
    if (_quesIndex < widget.questions.length - 1) {
      _increaseIndex();
      // we are making this check because we have 2 scenario
      // 1. user complete their ques
      // 2. user review their answer (after completing)
      if (_isNextQuestionOptionSelected()) {
        _makeDefaultDesign();
      } else {
        _optionHasSelected();
      }
      setState(() {});
      return;
    }
    // if (widget.quesIndex != null) {
    //   TemplateFactory().deleteSavedData();
    // }
    _showScore();
  }

  void _optionHasSelected({int? index}) {
    _isOptionSelected = true;
    _optionSelectedIndex = index ??= _getSelectedOption();
  }

  void _makeDefaultDesign() {
    _isOptionSelected = false;
    _optionSelectedIndex = _noOptionSelectedIndex;
  }

  void _onPreviousButtonClick() {
    setState(() {
      _decreaseIndex();
      _optionHasSelected();
    });
  }

  int _getSelectedOption() {
    return widget.questions[_quesIndex].selectedOptionIndex!;
  }

  void _decreaseIndex() {
    _quesIndex--;
  }

  // void _updateScore() {
  //   if (_checkAnswer()) {
  //     _increaseScore();
  //   }
  // }

  // void _increaseScore() {
  //   TemplateFactory templateFactory = TemplateFactory();
  //   templateFactory.increaseScore();
  // }

  void _increaseIndex() {
    _quesIndex++;
  }

  // bool _checkAnswer() {
  //   num answer = widget.questions[_quesIndex].answer;
  //   return answer == _optionSelectedIndex;
  // }

  void _showScore() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return ScoreScreen(
        // questionNo: _questionNo,
        questions: widget.questions,
      );
    }));
  }

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
