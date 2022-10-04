import 'package:flutter/material.dart';
import '/provider/time_provider.dart';
import 'package:provider/provider.dart';

class QuizScreenAppBar extends StatelessWidget {
  const QuizScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              label: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              )),
          Container(
            height: height * 0.08,
            width: width * 0.15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.grey.shade200, width: 4)),
            child: Consumer<TimeProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Text(
                  value.duration.getTime(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
