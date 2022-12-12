import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const CustomButton({required this.onButtonPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: onButtonPressed,
      child: Container(
        // height: 70,
        height: height * 0.0922,
        alignment: Alignment.center,
        width: width * 0.817,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(231, 76, 60, 1),
            borderRadius: BorderRadius.circular(height * 0.0352),
            boxShadow: [
              BoxShadow(
                  offset: Offset(
                      0,
                      // 9
                      height * 0.0119),
                  color: const Color.fromRGBO(192, 57, 43, 1))
            ]),
        child: Text(
          'NEXT',
          style: TextStyle(
              color: const Color.fromRGBO(255, 250, 240, 1),
              fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
              fontWeight: FontWeight.w900,
              fontSize: height * 0.0281),
        ),
      ),
    );
  }
}
