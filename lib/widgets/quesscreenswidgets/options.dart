import 'package:flutter/material.dart';
import '/screens/ques_screen.dart';

class Options extends StatefulWidget {
  final List<num> option;
  final QuesScreenState quesScreen;

  const Options({required this.option, required this.quesScreen, Key? key})
      : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  static const noOptionSelectedIndex = -1;
  int _optionSelectedIndex = noOptionSelectedIndex;

  @override
  void didUpdateWidget(covariant Options oldWidget) {
    if (oldWidget.hashCode != widget.hashCode) {
      _optionSelectedIndex = noOptionSelectedIndex;
      widget.quesScreen.optionSelected = noOptionSelectedIndex;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    //310
    print('height is ${height * 0.4079}');

    return Container(
      // color: Colors.red,
      // height: height * 0.2,
      alignment: Alignment.center,
      // height: 310,
      height: height * 0.4079,
      width: width,
      child: GridView.builder(
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
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
          bool isOptionSelected = _optionSelectedIndex == index;

          num option = widget.option[index];

          return Align(
            child: InkWell(
              highlightColor: Theme.of(context).backgroundColor,
              onTap: () {
                _onOptionSelected(index, option);
              },
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
                  width: width * 0.16112,
                  child: Text(
                    widget.option[index].toString(),
                    style: TextStyle(
                        // fontSize: 20,
                        fontSize: height * 0.02632,
                        fontWeight: FontWeight.w900,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily),
                  ),
                ),
              ),
            ),
          );
        },
      ),

      // child: GridView.builder(
      //     physics: const BouncingScrollPhysics(),
      //     // padding: const EdgeInsets.all(0),
      //     clipBehavior: Clip.none,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         mainAxisSpacing: 10,
      //         crossAxisSpacing: 5,
      //         mainAxisExtent: height * 0.09,
      //         crossAxisCount: 2
      //     ),
      //     itemCount: widget.option.length,
      //     itemBuilder: (_, index) {
      //       return _buildOption(height, width, index);
      //     }),
    );
  }

  // Widget _buildOption(double height, double width, int index) {
  //   final num optionValue = widget.option[index];
  //   return Align(
  //     child: Container(
  //         height: height * 0.08,
  //         width: width * 0.5,
  //         decoration: BoxDecoration(
  //             color: Theme.of(context).colorScheme.onBackground,
  //             gradient: _optionSelectedIndex == index
  //                 ? const LinearGradient(colors: [
  //                     Color.fromRGBO(231, 89, 153, 1),
  //                     Color.fromRGBO(188, 108, 234, 1)
  //                   ])
  //                 : null,
  //             borderRadius: BorderRadius.circular(height * 0.025)),
  //         alignment: Alignment.center,
  //         child: InkWell(
  //           onTap: () => _onOptionSelected(index, optionValue),
  //           child: Text(
  //             optionValue.toString(),
  //             style: const TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )),
  //   );
  // }

  void _onOptionSelected(int index, num selectedOption) {
    setState(() {
      _optionSelectedIndex = index;
      widget.quesScreen.optionSelected = selectedOption;
    });
  }
}
