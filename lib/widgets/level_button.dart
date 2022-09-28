import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonClick;
  final bool isSelected;

  const OptionButton(
      {required this.buttonText,
        required this.isSelected,
      required this.buttonClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected?Colors.black:null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            side: const BorderSide(color: Colors.black87, width: 0.15),
            minimumSize: Size(width, height * 0.07)),
        onPressed: buttonClick,
        child: Text(
          buttonText,
          style: TextStyle(color:isSelected? Colors.white:Colors.black, fontSize: 20),
        ));
  }
}
