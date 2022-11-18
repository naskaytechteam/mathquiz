import 'package:flutter/material.dart';
import 'package:mathquiz/screens/ques_screen.dart';

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

    return SizedBox(
      height: height * 0.2,
      width: width,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          clipBehavior: Clip.none,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              mainAxisExtent: height * 0.09,
              crossAxisCount: 2),
          itemCount: widget.option.length,
          itemBuilder: (_, index) {
            return _buildOption(height, width, index);
          }),
    );
  }

  Widget _buildOption(double height, double width, int index) {
    final num optionValue = widget.option[index];
    return Align(
      child: Container(
          height: height * 0.08,
          width: width * 0.5,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              gradient: _optionSelectedIndex == index
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(231, 89, 153, 1),
                      Color.fromRGBO(188, 108, 234, 1)
                    ])
                  : null,
              borderRadius: BorderRadius.circular(height * 0.025)),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () => _onOptionSelected(index, optionValue),
            child: Text(
              optionValue.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),
    );
  }

  void _onOptionSelected(int index, num selectedOption) {
    setState(() {
      _optionSelectedIndex = index;
      widget.quesScreen.optionSelected = selectedOption;
    });
  }
}
