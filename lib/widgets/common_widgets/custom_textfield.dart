import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../database/db_helper.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final bool isClassTextField;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(int? value)? onClassSelected;

  const CustomTextField(
      {required this.hintText,
      this.validator,
      required this.controller,
      this.onClassSelected,
      this.readOnly = false,
      this.textInputType=TextInputType.text,
      this.isClassTextField = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      // onSubmitted: onSubmit,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
          prefix: SizedBox(
            width: width * 0.0667,
          ),
          hintStyle: TextStyle(
              color: const Color.fromRGBO(189, 195, 199, 1),
              // fontSize: 20,
              fontSize: height * 0.0264,
              fontWeight: FontWeight.w700),
          hintText: hintText,
          focusedBorder: _buildInputBorder(width, height),
          enabledBorder: _buildInputBorder(width, height),
          errorBorder: _buildInputBorder(width, height, Colors.red),
          border: _buildInputBorder(width, height),
          suffixIcon:
              isClassTextField ? _dropDownWidget(context, height) : null),
    );
  }

  Widget _dropDownWidget(BuildContext context, double height) {
    return DropdownButton<int>(
      underline: const SizedBox(),
      elevation: 0,
      focusColor: Theme.of(context).colorScheme.background,
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
