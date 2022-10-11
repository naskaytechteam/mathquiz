import 'package:flutter/material.dart';
import '/widgets/score_details.dart';
import '/widgets/your_point.dart';

class ScoreScreen extends StatelessWidget {
  final int currentQuestionIndex;

  const ScoreScreen({required this.currentQuestionIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            _buildYourScore(height, width),
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined,
                      color: Colors.white),
                )),
            Positioned(
              bottom: 0,
              child: _buildBottomWidget(height, width),
            ),
            const Positioned(top: 50, left: 0, right: 0, child: YourPoint()),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ScoreDetails(currentQuestionIndex: currentQuestionIndex),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYourScore(double height, double width) {
    return Container(
      height: height * 0.5,
      width: width,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(56, 61, 110, 1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
    );
  }

//refactor Name
  Widget _buildSixWidget(double height, double width, int index) {
    List<IconData> iconList = [
      Icons.refresh,
      Icons.remove_red_eye,
      Icons.share,
      Icons.picture_as_pdf,
      Icons.home,
      Icons.star
    ];
    List<Color> colorsList = [
      const Color.fromRGBO(83, 145, 179, 1),
      const Color.fromRGBO(192, 141, 110, 1),
      const Color.fromRGBO(117, 94, 211, 1),
      Colors.blue,
      const Color.fromRGBO(190, 112, 159, 1),
      Colors.black38
    ];
    List<String> textList = [
      'Play Again',
      'Review Answer',
      'Share Score',
      'Generate PDF',
      'Home',
      'Leaderboard'
    ];
    return SizedBox(
      height: height * 0.12,
      width: width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: colorsList[index],
            radius: 30,
            child: Icon(iconList[index], color: Colors.white),
          ),
          Text(
            textList[index],
          )
        ],
      ),
    );
  }

  Widget _buildBottomWidget(double height, double width) {
    return SizedBox(
      height: height * 0.4,
      width: width,
      child: GridView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 0),
          itemBuilder: (_, index) {
            return Align(
              child: _buildSixWidget(height, width, index),
            );
          }),
    );
  }
}
//·
