import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/database/db_helper.dart';
import '/parsers/template_parser.dart';
import '/provider/template_factory.dart';
import '/screens/ques_screen.dart';

class ResumeYourLesson extends StatelessWidget {
  const ResumeYourLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: () => _onResumeLesionClick(context),
      child: Container(
        height: height * 0.1737,
        width: width * 0.8195,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(52, 152, 219, 1),
            borderRadius: BorderRadius.circular(height * 0.033),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, height * 0.0093),
                  color: const Color.fromRGBO(41, 128, 185, 1)),
            ]),
        child: Stack(
          children: [
            Positioned(
              left: width * 0.05556,
              top: height * 0.029,
              child: SizedBox(
                height: height * 0.04343,
                width: width * 0.4889,
                child: Text(
                  'Let’s Continue',
                  style: TextStyle(
                      fontSize: height * 0.03158,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromRGBO(241, 196, 15, 1)),
                ),
              ),
            ),
            Positioned(
              left: width * 0.053,
              top: height * 0.08422,
              child: SizedBox(
                height: height * 0.0579,
                width: width * 0.4278,
                child: Text(
                  'Resume your lesson on Geometry',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.0211,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              right: width * 0.05,
              top: height * 0.1,
              child: Icon(Icons.chevron_right,
                  color: Colors.white, size: height * 0.05),
            ),
            Positioned(
                left: width * 0.09167,
                top: height * 0.0211,
                child: SizedBox(
                    height: height * 0.1329,
                    width: width * 0.663,
                    child: SvgPicture.asset('assets/images/arrow.svg')))
          ],
        ),
      ),
    );
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

  void _setClassNo(TemplateFactory templateFactory, int classNo) {
    templateFactory.classNo = classNo;
  }

  void _onResumeLesionClick(BuildContext context) async {
    NavigatorState state = Navigator.of(context);
    _showProgressIndicator(context);
    final TemplateFactory templateFactory = TemplateFactory();
    List<Map<String, Object?>> savedQuizData =
        await templateFactory.getSavedQuizData();
    // TemplateType templateType = TemplateType.simple;
    state.pop();
    if (savedQuizData.isNotEmpty) {
      int? index;
      // for (var element in savedQuizData) {
      TemplateType templateType=TemplateType.values[savedQuizData[0][DbHelper.quesType]as int ];
        index = savedQuizData[0][DbHelper.index] as int;
        _setClassNo(templateFactory, savedQuizData[0][DbHelper.classNo] as int);
        // break;
      // }

      state.push(MaterialPageRoute(builder: (_) {
        return QuesScreen(
          templateType: templateType,
          questions: TemplateParser.questionsList(savedQuizData),
          quesIndex: index,
        );
      }));
    }
  }
}
