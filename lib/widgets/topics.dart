import 'package:flutter/material.dart';
import '/widgets/common_widgets/custom_gridview.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '/provider/template_factory.dart';
import '/screens/ques_screen.dart';
import '../model/question.dart';

class Topics extends StatelessWidget {
  final int classNo;
  final List<int> quesTypeList;

  const Topics({required this.classNo, required this.quesTypeList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Class $classNo',
        height: height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildGap(height * 0.04737),
            Container(
              // height: 22,
              height: height * 0.029,
              width: width,
              padding: EdgeInsets.only(left: /*40*/ width * 0.1112),
              child: Text(
                'Topics',
                style: TextStyle(
                    // fontSize: 16,
                    fontSize: height * 0.0211,
                    fontWeight: FontWeight.w900),
              ),
            ),
            _buildGap(height * 0.01975),
            CustomGridView(
              totalHeight: height * 0.75,
              mainAxisExtent: height * 0.218,
              onButtonClick: (index) {
                _onButtonClick(
                    context, TemplateType.values[quesTypeList[index]]);
              },
              itemCount: quesTypeList.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGap(double height) {
    return SizedBox(height: height);
  }

  void _showProgressIndicator(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _removeProgressIndicator(NavigatorState state) {
    state.pop();
  }

  void _onButtonClick(BuildContext context, TemplateType templateType) async {
    NavigatorState navigatorState = Navigator.of(context);
    _showProgressIndicator(context);
    List<Question> questions =
        await TemplateFactory().generateQuestions(templateType);
    _removeProgressIndicator(navigatorState);
    if (questions.isNotEmpty) {
      _goToQuesScreen(questions, navigatorState, templateType);
    }
  }

  void _goToQuesScreen(List<Question> questions, NavigatorState navigatorState,
      TemplateType templateType) {
    navigatorState.push(MaterialPageRoute(builder: (_) {
      return QuesScreen(templateType: templateType, questions: questions);
    }));
  }
}
