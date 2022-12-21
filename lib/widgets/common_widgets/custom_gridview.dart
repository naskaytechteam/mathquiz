import 'package:flutter/material.dart';
import '../../provider/template_factory.dart';
import 'custom_button.dart';

class CustomGridView extends StatelessWidget {
  final int? itemCount;
  final double totalHeight;
  final double mainAxisExtent;
  final Function(BuildContext context, int index)? onButtonClick;
  final bool isTopicScreen;
  final String? buttonName;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSize;

  const CustomGridView(
      {this.itemCount,
      required this.totalHeight,
      required this.mainAxisExtent,
      this.onButtonClick,
      this.buttonName,
      this.containerHeight,
      this.containerWidth,
      this.fontSize,
      this.isTopicScreen = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return SizedBox(
      // height: 234,
      height: totalHeight,
      width: width,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount ?? TemplateType.values.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 137 / 150
            // mainAxisExtent: 165
            mainAxisExtent: mainAxisExtent
            // mainAxisExtent: height * 0.24606
            ),
        padding: EdgeInsets.only(
            // left: 40,
            left: width * 0.1112,
            // right: 19
            right: width * 0.053),
        // scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Column(
            children: [
              CustomButton(
                height: containerHeight ?? height * 0.154,
                width: containerWidth ?? width * 0.3806,
                buttonName: isTopicScreen ? '' : '${index + 1}',
                backgroundColor: const Color.fromRGBO(236, 240, 241, 1),
                shadowColor: const Color.fromRGBO(189, 195, 199, 1),
                shadowHeight: height * 0.0093,
                textColor: Colors.black,
                fontSize: fontSize,
                onButtonPressed: onButtonClick == null
                    ? null
                    : () => onButtonClick!(context, index),
                margin: EdgeInsets.only(right: width * 0.0584),
              ),
              SizedBox(
                // height: 11,
                height: height * 0.01449,
              ),
              Container(
                width: width,
                // color: Colors.red,
                margin: EdgeInsets.only(
                    right:
                    // 21
                    width * 0.0584),
                alignment: Alignment.topCenter,
                // height: 15,
                height: height * 0.026,
                child: Text(
                    isTopicScreen
                        ? TemplateType.values[index].name
                        : 'Class ${index + 1}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        // fontSize: 14,
                        fontSize: height * 0.0185)),
              ),
            ],
          );
        },
      ),
    );
  }
}
