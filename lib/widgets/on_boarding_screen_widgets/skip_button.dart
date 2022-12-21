import 'package:flutter/material.dart';

import '../../screens/details_screen.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: height * 0.05,
        width: width * 0.3,
        child: TextButton(
          // style: TextButton.styleFrom(
          // padding: const EdgeInsets.only(right: 41),
          // ),
          onPressed: () => onSkip(context),
          child: Text(
            'SKIP',
            style: TextStyle(
              color: const Color.fromRGBO(127, 140, 141, 1),
              fontSize: height * 0.0225,
              // fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }

  void onSkip(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return const DetailsScreen();
    }));
  }
}