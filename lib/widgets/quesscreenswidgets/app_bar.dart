import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: Color.fromRGBO(56, 61, 110, 1),
            child: Icon(Icons.arrow_back),
          )),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Live Quiz',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
