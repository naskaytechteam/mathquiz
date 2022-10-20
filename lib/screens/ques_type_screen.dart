import 'package:flutter/material.dart';
import '../widgets/questypesscreenwidgets/ques_names.dart';
import '/screens/ques_screen.dart';
import 'package:provider/provider.dart';
import '/provider/quiz_provider.dart';

class QuesTypeScreen extends StatefulWidget {
  const QuesTypeScreen({Key? key}) : super(key: key);

  @override
  State<QuesTypeScreen> createState() => _QuesTypeScreenState();
}

class _QuesTypeScreenState extends State<QuesTypeScreen> {
  double firstImagePositionFromTop = 0,
      secondImagePositionFromTop = 0,
      thirdImagePositionFromTop = 0,
      forthImagePositionFromTop = 0,
      fifthImagePositionFromTop = 0,
      sixImagePositionFromTop = 0,
      sevenImagePositionFromTop = 0,
      eightImagePositionFromTop = 0,
      nineImagePositionFromTop = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
        body: NotificationListener(
            onNotification: (v) {
              if (v is ScrollUpdateNotification) {
                setState(() {
                  firstImagePositionFromTop -= v.scrollDelta! / 1.9;
                  secondImagePositionFromTop -= v.scrollDelta! / 1.8;
                  thirdImagePositionFromTop -= v.scrollDelta! / 1.7;
                  forthImagePositionFromTop -= v.scrollDelta! / 1.6;
                  fifthImagePositionFromTop -= v.scrollDelta! / 1.5;
                  sixImagePositionFromTop -= v.scrollDelta! / 1.4;
                  sevenImagePositionFromTop -= v.scrollDelta! / 1.3;
                  eightImagePositionFromTop -= v.scrollDelta! / 1.1;
                  nineImagePositionFromTop -= v.scrollDelta! / 1.2;
                });
              }
              return true;
            },
            child: Stack(
              children: [
                _buildParallaxImages(1, firstImagePositionFromTop, height),
                _buildParallaxImages(2, secondImagePositionFromTop, height),
                _buildParallaxImages(3, thirdImagePositionFromTop, height),
                _buildParallaxImages(4, forthImagePositionFromTop, height),
                _buildParallaxImages(5, fifthImagePositionFromTop, height),
                _buildParallaxImages(6, sixImagePositionFromTop, height),
                _buildParallaxImages(7, sevenImagePositionFromTop, height),
                _buildParallaxImages(8, eightImagePositionFromTop, height),
                _buildParallaxImages(9, nineImagePositionFromTop, height),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.3,
                        width: width,
                      ),
                      for (int a = 0; a < QUESTYPE.values.length; a++)
                        Container(
                          width: width,
                          color: const Color.fromRGBO(54, 58, 102, 1),
                          child: QuesNames(
                            color: Colors.primaries[a],
                            onQuesTypeSelected: _onQuesTypeSelected,
                            questype: QUESTYPE.values[a],
                          ),
                        )
                    ],
                  ),
                )
              ],
            )));
  }

  Widget _buildParallaxImages(int image, double top, double height) {
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: SizedBox(
        height: height * 0.3,
        child: Image(
          image: AssetImage('assets/$image.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _onQuesTypeSelected(QUESTYPE questype) async {
    NavigatorState navigatorState = Navigator.of(context);
    QuizProvider provider = Provider.of<QuizProvider>(context, listen: false);
    await provider.readDataFromDatabase(questype);
    if (provider.quesTemplateList.isEmpty) {
      _showDialogBox();
      return;
    }

    navigatorState.push(MaterialPageRoute(builder: (_) {
      return QuesScreen(
        quizType: questype.name,
      );
    }));
  }

  void _showDialogBox() {
    showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
            content: Text('No question found'),
          );
        });
  }

  // Widget _gap(double height) {
  //   return SizedBox(
  //     height: height,
  //   );
  // }
}
