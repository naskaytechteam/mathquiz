import 'package:flutter/material.dart';

import '../../screens/details_screen.dart';

class SkipButton extends StatelessWidget {
  final double fontSize;

  const SkipButton({required this.fontSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      height: height * 0.05,
      width: width,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          style: TextButton.styleFrom(padding:const EdgeInsets.only(right: 41)),
          onPressed: () => onSkip(context),
          child: Text(
            'SKIP',
            style: TextStyle(
              color: const Color.fromRGBO(127, 140, 141, 1),
              fontSize: /*height * 0.5*/ fontSize,
              fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
              // fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }

  void onSkip(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, animation, secondAnimation) {
              return const DetailsScreen();
            },
            transitionsBuilder: (_, animation, secondAnimation, widget) {
              Animation<Offset> customAnimation =
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(animation);
              return SlideTransition(
                position: customAnimation,
                child: widget,
              );
            }));
  }
}
