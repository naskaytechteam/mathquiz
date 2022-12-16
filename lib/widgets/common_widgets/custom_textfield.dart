import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../database/db_helper.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isClassTextField;
  final bool readOnly;
  final void Function(int? value)? onClassSelected;
  final void Function(String value)? onSubmit;

  const CustomTextField(
      {required this.hintText,
      required this.controller,
      this.onClassSelected,
      this.onSubmit,
      this.readOnly = false,
      required this.textInputType,
      this.isClassTextField = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      // height: 70,
      height: height * 0.0922,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          // left: 24
          left: width * 0.0667),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              // 25
              height * 0.033),
          border: Border.all(
            color: const Color.fromRGBO(44, 62, 80, 1),
            // width: 3
            width: width * 0.0084,
          )),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        onSubmitted: onSubmit,
        readOnly: readOnly,
        decoration: InputDecoration(
            hintStyle: TextStyle(
                color: const Color.fromRGBO(189, 195, 199, 1),
                // fontSize: 20,
                fontSize: height * 0.0264,
                fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                fontWeight: FontWeight.w700),
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon:
                isClassTextField ? _dropDownWidget(context, height) : null),
      ),
    );
  }

  Widget _dropDownWidget(BuildContext context, double height) {
    return DropdownButton<int>(
      underline: const SizedBox(),
      elevation: 0,
      focusColor: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      icon: SvgPicture.asset(
        'assets/images/dropdown.svg',
        // height: 12
        // height: height* 0.0158,
        // width: 10
        // width: width* 0.028,
      ),
      // iconSize: 20,
      iconSize: height * 0.0264,
      items: List.generate(
          DbHelper.totalClass, //totalClass
          (index) => DropdownMenuItem(
                value: index + 1,
                child: Text((index + 1).toString()),
              )),
      onChanged: onClassSelected!,
    );
  }
}
