import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    moveToNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 105,
              left: 0,
              right: 0,
              child: Align(
                child: Container(
                  width: width,
                  height: 27,
                  alignment: Alignment.center,
                  // color: Colors.red,
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                child: Container(
                  width: width,
                  height: 78,
                  alignment: Alignment.center,
                  // color: Colors.red,
                  child: Text.rich(
                    const TextSpan(
                        text: 'Olym',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                        children: [
                          TextSpan(
                              text: 'Math',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ))
                        ]),
                    style: TextStyle(
                        color: const Color.fromRGBO(231, 76, 60, 1),
                        fontSize: 57,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily),
                  ),
                ),
              ), //389 364.65
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/welcomeimage.svg',
                  height: 190,
                  width: 228,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> moveToNextPage() async {
    NavigatorState state = Navigator.of(context);
    await Future.delayed(const Duration(milliseconds: 300));
    state.pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(seconds: 5),
        pageBuilder: (_, animation, secondAnimation) {
          return const OnBoardingScreen();
        },
        transitionsBuilder: (_, animation, secondAnimation, widget) {
          Animation<Offset> position =
              Tween<Offset>(begin:const Offset(0.0, -2.0), end: Offset.zero).animate(
                  CurvedAnimation(
                      parent: animation, curve: Curves.bounceInOut));
          return SlideTransition(
            position: position,
            child: widget,
          );
        }));
  }
}
//93.4032
