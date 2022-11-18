import 'package:flutter/material.dart';
import '/provider/template_factory.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double height;
  final VoidCallback? onPdfGenerated;

  Appbar(
      {this.title = 'Live Quiz',
      VoidCallback? onPdfGenerate,
      required this.height,
      Key? key})
      :onPdfGenerated=onPdfGenerate??((){}), super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      leading: IconButton(
          onPressed: () {
            TemplateFactory().resetScore();
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            child: const Icon(Icons.arrow_back),
          )),
      actions: [
        Align(
          child: TextButton(
            onPressed: onPdfGenerated,
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(width * 0.3, height * 0.04)),
            child: const Text(
              'Generate Pdf',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(height * 0.07);
}
