import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const Appbar({this.title='Live Quiz',Key? key}) : super(key: key);

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
      title:  Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
