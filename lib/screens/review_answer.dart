import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/widgets/common_widgets/custom_app_bar.dart';
import '../widgets/common_widgets/custom_button.dart';
import '../model/question.dart';

class ReviewAnswer extends StatefulWidget {
  final List<Question> questions;

  const ReviewAnswer({required this.questions, Key? key}) : super(key: key);

  @override
  State<ReviewAnswer> createState() => _ReviewAnswerState();
}

class _ReviewAnswerState extends State<ReviewAnswer> {
  int _quesIndex = 0;

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
              // Options(quesScreen: this, option: question.options),
              _gap(/*90*/height * 0.11843),
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
          int _optionSelectedIndex = 1;
          bool isOptionSelected = _optionSelectedIndex == index;

          num option = widget.questions[_quesIndex].options[index];

          return Align(
            child: InkWell(
              highlightColor: Theme.of(context).backgroundColor,
              onTap: () {
                // _onOptionSelected(index, option);
              },
              child: Container(
                alignment: Alignment.center,
                // height: 137,
                height:  height * 0.1803,
                // margin: const EdgeInsets.only(right: 20),
                // width: 137,
                width: width * 0.38056,
                decoration: BoxDecoration(
                    color: isOptionSelected
                        ? const Color.fromRGBO(241, 196, 15, 1)
                        : Color.fromRGBO(236, 240, 241, 1),
                    borderRadius: BorderRadius.circular(/*25*/height * 0.033),
                    boxShadow: [
                      BoxShadow(
                          color: isOptionSelected
                              ? Color.fromRGBO(243, 156, 18, 1)
                              : Color.fromRGBO(189, 195, 199, 1),
                          offset: Offset(0, /*7*/height * 0.0093))
                    ]),
                child: Container(
                  // height: 65,
                  height: height * 0.0856,
                  alignment: Alignment.center,
                  // width: 58,
                  width: width * 0.16112,
                  child: Text(
                    option.toString(),
                    style: TextStyle(
                        // fontSize: 20,
                      fontSize: height * 0.0264,
                        fontWeight: FontWeight.w900,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

/*
  Widget _buildOptions(double height, double width, Question question) {
    return SizedBox(
      height: height * 0.2,
      width: width,
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              mainAxisExtent: height*0.09,
              crossAxisCount: 2),
          itemCount: question.options.length,
          itemBuilder: (_, index) {
            return _buildOptionDesign(height, width, index, question);
          }),
    );
  }

 */

  // Widget _buildOptionDesign(
  //     double height, double width, int index, Question question) {
  //   return Align(
  //     child: Container(
  //         height: height * 0.08,
  //         width: width * 0.5,
  //         decoration: BoxDecoration(
  //             color: question.answer == question.options[index]
  //                 ? Theme.of(context).colorScheme.primaryContainer
  //                 : Theme.of(context).colorScheme.onBackground,
  //             borderRadius: BorderRadius.circular(height * 0.025)),
  //         alignment: Alignment.center,
  //         child: Text(
  //           question.options[index].toString(),
  //           style: TextStyle(
  //               color: Colors.white, fontSize: /*20*/ height * 0.0264),
  //         )),
  //   );
  // }

  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
