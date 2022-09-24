import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String optionType;
  final String option;

  const OptionButton({required this.optionType, required this.option,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return TextButton.icon(
        onPressed: () {},
        icon: Container(
          height: height * 0.04,
          width: width * 0.08,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.8),
              borderRadius: BorderRadius.circular(19)),
          child: Text(
            optionType,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        style: TextButton.styleFrom(
            minimumSize: Size(width * 0.35, height * 0.03),
            side: const BorderSide(width: 0.1, color: Colors.black),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        label: Text(
          option,
          style:const TextStyle(
              color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
