import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/provider/quiz_provider.dart';

import '../../provider/quiz_provider.dart';

class QuesTypeName extends StatelessWidget {
  final QUESTYPE questype;
  final Function(QUESTYPE questype) onQuesTypeSelected;

  const QuesTypeName(
      {required this.questype, required this.onQuesTypeSelected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      width: width,
      color: const Color.fromRGBO(33, 0, 2, 1),
      child: InkWell(
        onTap: () => onQuesTypeSelected(questype),
        child: Container(
          width: width * 0.8,
          height: height * 0.13,
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.1, vertical: height * 0.02),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(45, 10, 13, 1),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Container(
                width: width * 0.25,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/simple.png'))),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              SizedBox(
                width: width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                      width: width,
                      child: AutoSizeText(
                        questype.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                      child: const Text('Step 03/10',
                          style: TextStyle(color: Colors.white70)),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const LinearProgressIndicator(
                      value: 1,
                      backgroundColor: Colors.red,
                      color: Color.fromRGBO(54, 58, 102, 1),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
