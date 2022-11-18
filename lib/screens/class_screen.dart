import 'package:flutter/material.dart';
import '/database/db_helper.dart';
import '/provider/template_factory.dart';
import '/screens/home_screen.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: ListView.builder(
          itemCount: DbHelper.totalClass,
          itemBuilder: (_, index) {
            return _buildClassContainer(width, height, index, context);
          }),
    ));
  }

  Widget _buildClassContainer(
      double width, double height, int index, BuildContext context) {
    final classNo = index + 1;
    return InkWell(
      onTap: () async {
        NavigatorState navigatorState = Navigator.of(context);
        List<int> list = await TemplateFactory().getQuesTypes(classNo);
        navigatorState.pushReplacement(MaterialPageRoute(builder: (_) {
          return HomeScreen(quesTypeList: list);
        }));
        //next button
        // leader board
        //friend challenge
        //adapty in app purchase
        // ios app
      },
      child: Container(
        width: width,
        height: height * 0.1,
        color: Colors.blueGrey,
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        child: Text(
          'class no $classNo',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
