import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/screens/home_screen.dart';
import 'on_boarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    _moveToNextPageAccordingToUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? nunitoFamily = Theme
        .of(context)
        .textTheme
        .headline2
        ?.fontFamily;

    Size size = MediaQuery
        .of(context)
        .size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: SizedBox(
        child: Stack(
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
                  child: Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: height * 0.0264,
                        fontWeight: FontWeight.w700,
                        fontFamily: nunitoFamily),
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
                  // height: 78,
                  height: height * 0.1027,
                  // alignment: Alignment.center,
                  // color: Colors.red,
                  child: Text.rich(
                    TextSpan(
                        text: 'Olym',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          // fontSize: 57,
                          fontSize: height * 0.075,
                          fontFamily: nunitoFamily,
                          color: const Color.fromRGBO(231, 76, 60, 1),
                        ),
                        children: const [
                          TextSpan(
                              text: 'Math',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ))
                        ]),
                    textAlign: TextAlign.center,
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
                  // height: 190,
                  height: height * 0.25,
                  // width: 228,
                  width: width * 0.6334,
                ))
          ],
        ),
      ),
    );
  }

  void _goToNextPage(Widget nextPage) async {
    NavigatorState navigatorState = Navigator.of(context);
    await Future.delayed(const Duration(milliseconds: 300));
    navigatorState.pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(seconds: 4),
        pageBuilder: (_, animation, secondAnimation) {
          return nextPage;
        },
        transitionsBuilder: (_, animation, secondAnimation, widget) {
          return FadeTransition(
            opacity: animation,
            child: widget,
          );
        }));
  }

  Future<void> _moveToNextPageAccordingToUserData() async {
    Map? userData = await _getUserDetails();
    if (userData != null) {
      _goToNextPage(HomeScreen(
        name: userData['userName'],
        userClassNo: userData['classNo'],
        avatarNo: userData['avatarNo'],
        parentEmail: userData['parentEmail'],
      ));
      return;
    }

    _goToNextPage(const OnBoardingScreen());
  }
  Future<Map?> _getUserDetails() async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String? name = sharedPreferences.getString('userName');
    int? classNo = sharedPreferences.getInt('classNo');
    int? avatarNo = sharedPreferences.getInt('avatarNo');
    String? parentEmail = sharedPreferences.getString('parentEmail');
    return _isDataExists(name, classNo, avatarNo, parentEmail)
        ? {
      'userName': name,
      'classNo': classNo,
      'avatarNo': avatarNo,
      'parentEmail': parentEmail
    }
        : null;
  }
//need to change
  bool _isDataExists(String? name, int? classNo, int? avatarNo,
      String? parentEmail) {
    return name != null &&
        classNo != null &&
        avatarNo != null &&
        parentEmail != null;
  }

}
