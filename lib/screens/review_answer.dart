import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/common_widgets/custom_divider.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '../widgets/common_widgets/custom_button.dart';
import '../model/question.dart';

class ReviewAnswer extends StatefulWidget {
  final List<Question> questions;
  final int quesIndex;

  const ReviewAnswer(
      {required this.questions, required this.quesIndex, Key? key})
      : super(key: key);

  @override
  State<ReviewAnswer> createState() => _ReviewAnswerState();
}

class _ReviewAnswerState extends State<ReviewAnswer> {
  late int _quesIndex;

  @override
  void initState() {
    _quesIndex = widget.quesIndex;
    super.initState();
  }

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
        title: 'Question $_quesIndex',
        height: height * 0.1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.11112),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // height: 25,
                height: height * 0.033,
              ),
              SizedBox(
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
                      fontSize: height * 0.0264,
                      fontWeight: FontWeight.w600,
                      fontFamily:
                          Theme.of(context).textTheme.headline2?.fontFamily),
                ),
              ),
              SizedBox(
                // height: 40,
                height: height * 0.05264,
              ),
              buildOption(height, width),
              _gap(/*90*/ height * 0.11843),
              const CustomDivider(),
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
                        onPressed: () {
                          setState(() {
                            _quesIndex--;
                          });
                        },
                        child: Text(
                          'PREVIOUS',
                          style: TextStyle(
                              color: const Color.fromRGBO(231, 76, 60, 1),
                              // fontSize: 20,
                              fontSize:  height * 0.02632,
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
                      width:width * 0.36112,
                      onButtonPressed: _onNextButtonClick,
                      // backgroundColor: !checkOptionSelected?Colors.black:Colors.red,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNextButtonClick() {
    setState(() {
      _quesIndex++;
    });
  }

  Widget buildOption(
    double height,
    double width,
  ) {
    return Container(
      // color: Colors.red,
      // height: height * 0.2,
      alignment: Alignment.center,
      // height: 310,
      height: height * 0.4079,
      width: width,
      child: GridView.builder(
        itemCount: 4,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: height * 0.02632,
            // crossAxisSpacing: 15,
            crossAxisSpacing: width * 0.04167,
            // childAspectRatio: 137 / 137
            mainAxisExtent: /*140*/height * 0.18422),
        itemBuilder: (_, index) {
          Color backgroundColor = const Color.fromRGBO(236, 240, 241, 1);
          Color shadowColor = const Color.fromRGBO(189, 195, 199, 1);
          String? image;

          if (widget.questions[_quesIndex].selectedOptionIndex == index) {
            if (widget.questions[_quesIndex].options[index] ==
                widget.questions[_quesIndex].answer) {
              backgroundColor = const Color.fromRGBO(46, 204, 113, 1);
              shadowColor = const Color.fromRGBO(39, 174, 96, 1);
            } else {
              backgroundColor = const Color.fromRGBO(231, 76, 60, 1);
              shadowColor = const Color.fromRGBO(192, 57, 43, 1);
              image = 'wrong_answer2';
            }
          } else if (widget.questions[_quesIndex].answer ==
              widget.questions[_quesIndex].options[index]) {
            shadowColor = const Color.fromRGBO(39, 174, 96, 1);
            image = 'selected';
          }

          num option = widget.questions[_quesIndex].options[index];

          return Container(
            // alignment: Alignment.center,
            // height: 137,
            height: height * 0.1803,
            // margin: const EdgeInsets.only(right: 20),
            // width: 137,
            width: width * 0.38056,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(/*25*/ height * 0.033),
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      offset: Offset(0, /*7*/ height * 0.0093))
                ]),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    child: Text(
                      option.toString(),
                      style: TextStyle(
                          // fontSize: 20,
                          fontSize: height * 0.0264,
                          fontWeight: FontWeight.w900,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.fontFamily),
                    ),
                  ),
                ),
                if (image != null)
                  Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: SvgPicture.asset('assets/images/$image.svg'))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
