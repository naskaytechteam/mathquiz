import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';

class QuesTypes extends StatelessWidget {
  final Function onQuesTypeSelected;

  const QuesTypes({required this.onQuesTypeSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.yellow,
      Colors.purpleAccent,
      Colors.blue,
      Colors.grey.shade200,
      Colors.orange,
      Colors.green
    ];

    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      height: height * 0.63,
      width: width,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          //build_____Item
          return _buildQuestiontypeItem(
              height, width, index, colorList[index], QUESTYPE.values[index]);
        },
      ),
    );
  }

  Widget _buildQuestiontypeItem(
      double height, double width, int index, Color color, QUESTYPE questype) {
    return InkWell(
      onTap: () => onQuesTypeSelected(questype),
      child: SizedBox(
        height: height * 0.2,
        width: width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
              width: width * 0.25,
              child: Image.asset(
                'assets/simple.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            quesTypeName(index, height, width),
            Container(
              height: height * 0.01,
              width: width * 0.3,
              color: Colors.grey.shade200,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    height: height * 0.01,
                    width: width * 0.1 * index,
                    color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quesTypeName(int index, double height, double width) {
    return SizedBox(
      height: height * 0.045,
      width: width,
      child: AutoSizeText(
        QUESTYPE.values[index].name,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
