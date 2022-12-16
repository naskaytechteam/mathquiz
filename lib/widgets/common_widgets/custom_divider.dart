import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Divider(
      // height: 1,
      height: height * 0.0014,
      // thickness: 0.5,
      thickness: height * 0.0007,
      color: Colors.black,
    );
  }
}
