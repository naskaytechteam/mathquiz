import 'package:flutter/material.dart';

class RankingContainer extends StatelessWidget {
  final Color containerColor;
  final Color shadowColor;
  final String detailName;
  final String detailNo;

  const RankingContainer(
      {required this.containerColor,
      required this.detailName,
      required this.detailNo,
      required this.shadowColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // height: 184,
        height: height * 0.24211,
        // width: 137,
        width: width * 0.38057,
        margin: EdgeInsets.only(right: /*20*/ width * 0.05556),
        decoration: BoxDecoration(
            // color: Color.fromRGBO(241, 196, 15, 1),
            color: containerColor,
            borderRadius: BorderRadius.circular(/*25*/ height * 0.033),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, /*8*/ height * 0.0106), color: shadowColor
                  // color: Color.fromRGBO(243, 156, 18, 1))
                  )
            ]),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // color: Colors.red,
              // height: 44,
              height: height * 0.0579,
              // width: 100,
              width: width * 0.2778,
              // width: wid,
              child: Text(
                detailName,
                style: TextStyle(
                    // fontSize: 16,
                    fontSize: height * 0.0211,
                    color: Colors.white,
                    fontFamily:
                        Theme.of(context).textTheme.headline2?.fontFamily,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              // height: 65,
              height: height * 0.0856,
              // width: 58,
              child: Text(
                detailNo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily:
                        Theme.of(context).textTheme.headline2?.fontFamily,
                    // fontSize: 48
                    fontSize: height * 0.06316),
              ),
            )
          ],
        ),
      ),
    );
  }
}
