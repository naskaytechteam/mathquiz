import 'package:flutter/material.dart';

class QuesScreenAppBar extends StatelessWidget {
  const QuesScreenAppBar({Key? key}) : super(key: key);

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
          Container(
            height: height * 0.06,
            width: width * 0.13,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, -5),
                      color: Colors.white,
                      blurRadius: 100),
                  BoxShadow(
                      offset: Offset(1, 1), color: Colors.grey, blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(25)),
            child: const Icon(Icons.person),
          ),
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
