import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/quiz_provider.dart';
import '/screens/quiz_screen.dart';
import '/widgets/ques_screen_app_bar.dart';
import '/widgets/ques_types.dart';

class QuesScreen extends StatefulWidget {
  const QuesScreen({Key? key}) : super(key: key);

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 255, 0.3),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
          children: [
            _gap(height * 0.06),
            const QuesScreenAppBar(),
            _gap(height * 0.05),
            SizedBox(
                height: height * 0.1,
                width: width,
                child: const Text(
                  'Hey Charley, what subject you want to improve today',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )),
            _gap(height * 0.05),
            QuesTypes(onQuesTypeSelected: quesTypeSelected),
          ],
        ),
      ),
    );
  }

  void quesTypeSelected(QUESTYPE questype) async {
    NavigatorState navigatorState = Navigator.of(context);
    QuizProvider provider = Provider.of<QuizProvider>(context, listen: false);
    await provider.readData(questype);
    if(provider.quesTemplateList.isEmpty){
      showDialogBox();
      return;
    }
    navigatorState.push(MaterialPageRoute(builder: (_) {
      return const QuizScreen();
    }));
  }

  void showDialogBox(){
    showDialog(context: context, builder: (_){
      return const AlertDialog(content: Text('No question found'),);
    });
  }
  Widget _gap(double height) {
    return SizedBox(
      height: height,
    );
  }
}
