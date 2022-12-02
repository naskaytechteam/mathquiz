import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width,
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.5,
                    // color: Colors.yellow,
                    height: height * 0.1,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/homeimage1.svg',
                          height: 59,
                          width: 59,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          height: height * 0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Good evening',
                                style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.fontFamily,
                                    fontSize: 14,
                                    color:
                                    const Color.fromRGBO(51, 51, 51, 1)),
                              ),
                              Container(
                                height: 44,
                                width: 98,
                                child: Text(
                                  'Taylor',
                                  style: TextStyle(
                                      color:
                                      const Color.fromRGBO(52, 73, 94, 1),
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.fontFamily),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      'assets/images/bell.svg',
                      height: 25,
                      width: 25,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 43,
            ),
            Container(
              height: 207,
              width: 295,
              child: Stack(
                children: [
                  SvgPicture.asset('assets/images/firstrect.svg'),
                  SvgPicture.asset('assets/images/secondrect.svg'),
                  Positioned(
                      right: 0,
                      child: SvgPicture.asset('assets/images/pig.svg')),
                  Positioned(
                      top: 25,
                      left: 19,
                      child: SvgPicture.asset('assets/images/book.svg')),
                  Positioned(
                    left: 18,
                    top: 83,
                    child: Container(
                        height: 22,
                        width: 126,
                        child: Text(
                          'Today’s Topic',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.fontFamily),
                        )),
                  ),
                  Positioned(
                    top: 105,
                    left: 20,
                    child: Container(
                      height: 66,
                      width: 176,
                      child: Text(
                        'Probability Theory',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 121,
                      top: 162,
                      child: SvgPicture.asset(
                        'assets/images/star.svg',
                        height: 25.5,
                        width: 27,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 22,
                padding: const EdgeInsets.only(left: 40),
                width: 139,
                child: Text(
                  'Take a Quick Test',
                  style: TextStyle(
                      fontFamily:
                      Theme.of(context).textTheme.headline2?.fontFamily,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 170,
              width: width,
              child: ListView.builder(
                  padding:const EdgeInsets.only(left: 40),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Container(
                          height: 137,
                          margin:const EdgeInsets.only(right: 21),
                          width: 137,
                          decoration: BoxDecoration(
                              color:const Color.fromRGBO(236, 240, 241, 1),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow:const [
                                BoxShadow(
                                    color: Color.fromRGBO(189, 195, 199, 1),
                                    offset: Offset(0, 7))
                              ]),
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Container(
                          height: 15,
                          child: Text('Algebra'),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset('assets/images/resume.svg')
          ],
        ),
      ),
    );
  }
}
