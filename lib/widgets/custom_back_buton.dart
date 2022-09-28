import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      width: width,
      height: height * 0.1,
      child: TextButton.icon(
          onPressed: () {},
          style: TextButton.styleFrom(alignment: Alignment.centerLeft),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          label: const Text(
            'Back',
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
