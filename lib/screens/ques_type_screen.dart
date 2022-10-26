import 'package:flutter/material.dart';
import 'package:mathquiz/widgets/questypesscreenwidgets/ques_type_name.dart';
import '/screens/ques_screen.dart';
import 'package:provider/provider.dart';
import '/provider/quiz_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _firstImagePositionFromTop = 0,
      _secondImagePositionFromTop = 0,
      _thirdImagePositionFromTop = 0,
      _forthImagePositionFromTop = 0,
      _fifthImagePositionFromTop = 0,
      _sixImagePositionFromTop = 0,
      _sevenImagePositionFromTop = 0,
      _eightImagePositionFromTop = 0,
      _nineImagePositionFromTop = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      // backgroundColor: const Color.fromRGBO(54, 58, 102, 1),
        body: NotificationListener(
            onNotification: _handleScrollNotification,
            child: Stack(
              children: [
                _buildParallaxImages(1, _firstImagePositionFromTop, height),
                _buildParallaxImages(2, _secondImagePositionFromTop, height),
                _buildParallaxImages(3, _thirdImagePositionFromTop, height),
                _buildParallaxImages(4, _forthImagePositionFromTop, height),
                _buildParallaxImages(5, _fifthImagePositionFromTop, height),
                _buildParallaxImages(6, _sixImagePositionFromTop, height),
                _buildParallaxImages(7, _sevenImagePositionFromTop, height),
                _buildParallaxImages(8, _eightImagePositionFromTop, height),
                _buildParallaxImages(9, _nineImagePositionFromTop, height),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.3,
                        width: width,
                      ),
                      for (int a = 0; a < QUESTYPE.values.length; a++)
                        QuesTypeName(
                            questype: QUESTYPE.values[a],
                            onQuesTypeSelected: _onQuesTypeSelected)
                    ],
                  ),
                )
              ],
            )));
  }

  bool _handleScrollNotification(Object v) {
    if (v is ScrollUpdateNotification) {
      setState(() {
        _firstImagePositionFromTop -= v.scrollDelta! / 1.9;
        _secondImagePositionFromTop -= v.scrollDelta! / 1.8;
        _thirdImagePositionFromTop -= v.scrollDelta! / 1.7;
        _forthImagePositionFromTop -= v.scrollDelta! / 1.6;
        _fifthImagePositionFromTop -= v.scrollDelta! / 1.5;
        _sixImagePositionFromTop -= v.scrollDelta! / 1.4;
        _sevenImagePositionFromTop -= v.scrollDelta! / 1.3;
        _eightImagePositionFromTop -= v.scrollDelta! / 1;
        _nineImagePositionFromTop -= v.scrollDelta! / 1;
      });
    }
    return true;
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

  Future<void> _onQuesTypeSelected(QUESTYPE questype) async {
    NavigatorState navigatorState = Navigator.of(context);
    QuizProvider provider = Provider.of<QuizProvider>(context, listen: false);
    await provider.readDataFromDatabase(questype);
    if (provider.quesTemplateList.isEmpty) {
      _showDialogBox();
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
}
