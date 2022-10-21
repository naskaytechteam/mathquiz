import 'package:flutter/material.dart';

class ScoreContainer extends StatelessWidget {
  final int point;
  const ScoreContainer({required this.point,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Align(
      child: Container(
          height: height * 0.2,
          width: width * 0.4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(80)),
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
                text: 'Your Score \n',
                style: const TextStyle(fontSize: 20),
                children: [
                  TextSpan(
                      text: point.toString(),
                      style: const TextStyle(
                          fontSize: 34, fontWeight: FontWeight.w900)),
                  const TextSpan(
                      text: 'pt',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                ]),
            textAlign: TextAlign.center,
          )),
    );
  }
}
