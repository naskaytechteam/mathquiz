import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double height;

  const CustomAppBar({required this.title, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;

    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.chevron_left,
          // size: 40,
          size: screenHeight * 0.05264,
          color: const Color.fromRGBO(231, 76, 60, 1),
        ),
      ),
      toolbarHeight: height,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontSize: 18,
            fontSize:  screenHeight * 0.02369,
            color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
