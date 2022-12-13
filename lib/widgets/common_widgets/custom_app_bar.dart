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
      elevation: 0,
      backgroundColor: Colors.transparent,
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
      toolbarHeight: screenHeight * 0.1,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
            fontSize: 18,
            color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
