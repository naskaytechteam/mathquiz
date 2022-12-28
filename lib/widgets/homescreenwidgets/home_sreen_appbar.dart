import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  final double height;
  final String firstText;
  final String secondText;
  final List<Widget>? actions;

  const HomeScreenAppBar(
      {required this.height,
      required this.firstText,
      required this.secondText,
      this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double width = size.width;

    return AppBar(
      toolbarHeight: height,
      leadingWidth: 0,
      titleSpacing: width * 0.1,
      centerTitle: false,
      title: SizedBox(
        width: width * 0.6,
        child: Text.rich(
          TextSpan(
              text: '$firstText\n',
              style: TextStyle(
                  fontSize: screenHeight * 0.0185,
                  color: const Color.fromRGBO(51, 51, 51, 1)),
              children: [
                TextSpan(
                  text: secondText,
                  style: TextStyle(
                    color: const Color.fromRGBO(52, 73, 94, 1),
                    fontSize: screenHeight * 0.04215,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ]),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
