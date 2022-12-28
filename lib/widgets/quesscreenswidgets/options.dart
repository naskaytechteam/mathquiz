import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final List<num> option;
  final int optionSelectedIndex;
  final Function(int index) onOptionSelected;
  const Options({required this.option,
    required this.onOptionSelected,
    required this.optionSelectedIndex,super.key});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      // color: Colors.red,
      // height: height * 0.2,
      alignment: Alignment.center,
      // height: 310,
      height: height * 0.4079,
      width: width,
      child: GridView.builder(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisSpacing: 20,
            mainAxisSpacing: height * 0.02632,
            // crossAxisSpacing: 15,
            crossAxisSpacing: width * 0.04167,
            // childAspectRatio: 137 / 137
            // mainAxisExtent: 140
            mainAxisExtent: height * 0.18422),
        itemBuilder: (_, index) {
          bool isOptionSelected = optionSelectedIndex == index;

          return Align(
            child: InkWell(
              highlightColor: Theme.of(context).colorScheme.background,
              onTap: () =>onOptionSelected(index),
              child: Container(
                alignment: Alignment.center,
                // height: 137,
                height: height * 0.1803,
                // margin: const EdgeInsets.only(right: 20),
                // width: 137,
                width: width * 0.38056,
                decoration: BoxDecoration(
                    color: isOptionSelected
                        ? const Color.fromRGBO(241, 196, 15, 1)
                        : const Color.fromRGBO(236, 240, 241, 1),
                    borderRadius: BorderRadius.circular(/*25*/ height * 0.033),
                    boxShadow: [
                      BoxShadow(
                          color: isOptionSelected
                              ? const Color.fromRGBO(243, 156, 18, 1)
                              : const Color.fromRGBO(189, 195, 199, 1),
                          offset: Offset(0, /*7*/ height * 0.0093))
                    ]),
                child: Container(
                  // height: 65,
                  height: height * 0.0856,
                  alignment: Alignment.center,
                  // width: 58,
                  width: width,
                  // width: width * 0.16112,
                  child: Text(
                    option[index].toString(),
                    style: TextStyle(
                        // fontSize: 20,
                        fontSize: height * 0.02632,
                        fontWeight: FontWeight.w900,),
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
