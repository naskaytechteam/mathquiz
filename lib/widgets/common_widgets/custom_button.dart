import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final String? buttonName;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color shadowColor;
  // final bool isScoreScreenButton;
  final Widget? child;

  const CustomButton(
      {this.buttonName,
      required this.height,
      required this.width,
      this.child,
        this.textColor=const Color.fromRGBO(255, 250, 240, 1),
      // this.isScoreScreenButton = false,
      this.backgroundColor = const Color.fromRGBO(231, 76, 60, 1),
      this.shadowColor = const Color.fromRGBO(192, 57, 43, 1),
      this.onButtonPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    return InkWell(
      onTap: onButtonPressed,
      child: Container(
        height: height,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(screenHeight * 0.0352),
            boxShadow: [
              BoxShadow(
                  offset: Offset(
                      0,
                      // 9
                      screenHeight * 0.0119),
                  color: shadowColor)
            ]),
        child: child ?? Text(
                buttonName!,
                style: TextStyle(
                    color: const Color.fromRGBO(255, 250, 240, 1),
                    fontFamily:
                        Theme.of(context).textTheme.headline2?.fontFamily,
                    fontWeight: FontWeight.w900,
                    fontSize: screenHeight * 0.0281),
              ),
      ),
    );
  }
}
