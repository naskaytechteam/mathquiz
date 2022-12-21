import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './on_boarding_screen.dart';
import '../screens/home_screen.dart';
import '../utils/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 300),
        () => _pushNextPage(UserPreferences.isNewUser()
            ? const OnBoardingScreen()
            : const HomeScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: height * 0.1381579,
            left: 0,
            right: 0,
            child: Align(
              child: SizedBox(
                width: width,
                height: height * 0.0356,
                child: const Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
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
              child: SizedBox(
                width: width,
                height: height * 0.1027,
                child: const Text.rich(
                  TextSpan(
                      text: 'Olym',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 57,
                        color: Color.fromRGBO(231, 76, 60, 1),
                      ),
                      children: [
                        TextSpan(
                            text: 'Math',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ))
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/splash_image.svg',
              // height: 190,
              height: height * 0.25,
              // width: 228,
              width: width * 0.6334,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _pushNextPage(Widget nextPage) async {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (_, __, ___) {
          return nextPage;
        },
        transitionsBuilder: (_, animation, secondAnimation, widget) {
          return FadeTransition(
            opacity: animation,
            child: widget,
          );
        }));
  }
}
