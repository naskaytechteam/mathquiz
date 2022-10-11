import 'package:flutter/material.dart';
import '/screens/ques_screen.dart';
import 'package:provider/provider.dart';
import '/provider/quiz_provider.dart';
import '/widgets/ques_screen_app_bar.dart';
import '/widgets/ques_names.dart';

class QuesTypeScreen extends StatefulWidget {
  const QuesTypeScreen({Key? key}) : super(key: key);

  @override
  State<QuesTypeScreen> createState() => _QuesTypeScreenState();
}

class _QuesTypeScreenState extends State<QuesTypeScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 58, 102, 1),
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
            QuesNames(onQuesTypeSelected: _onQuesTypeSelected),
          ],
        ),
      ),
    );
  }

  void _onQuesTypeSelected(QUESTYPE questype) async {
    NavigatorState navigatorState = Navigator.of(context);
    QuizProvider provider = Provider.of<QuizProvider>(context, listen: false);
    await provider.readDataFromDatabase(questype);
    if(provider.quesTemplateList.isEmpty){
      _showDialogBox();
      return;
    }
    navigatorState.push(MaterialPageRoute(builder: (_) {
      return QuesScreen(quizType:questype.name,);
    }));
  }

  void _showDialogBox(){
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
