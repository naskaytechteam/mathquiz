import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/screens/details_screen.dart';
import '/widgets/onboardingscreenwidgets/on_boarding_page1.dart';
import '/widgets/onboardingscreenwidgets/on_boarding_page2.dart';
import '/widgets/onboardingscreenwidgets/on_boarding_page3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.808,
                width: width,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (nextPageIndex) {
                    pageIndex = nextPageIndex;
                  },
                  children: const [
                    OnBoardingPage1(),
                    OnBoardingPage2(),
                    OnBoardingPage3()
                  ],
                ),
              ),
              //todo this indicator is not dynamic(responsible)

              SizedBox(
                height: height * 0.02,
                width: width,
                // alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: SwapEffect(
                        dotColor: const Color.fromRGBO(127, 140, 141, 1),
                        // dotWidth: 10,
                        dotWidth: width * 0.028,
                        // dotHeight: 10,
                        dotHeight: height * 0.0132,
                        activeDotColor: const Color.fromRGBO(231, 76, 60, 1)),
                  ),
                ),
              ),
              SizedBox(
                // height: 33,
                height: height * 0.04344,
              ),
              CustomButton(
                onButtonPressed: onButtonPressed,
                buttonName: 'Next',
                height: height * 0.0922,
                width: width * 0.817,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToDetailsScreen() {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, animation, secondAnimation) {
              return const DetailsScreen();
            },
            transitionsBuilder: (_, animation, secondAnimation, widget) {
              Animation<Offset> an =
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(animation);
              return SlideTransition(
                position: an,
                child: widget,
              );
            }));
  }

  void onButtonPressed() {
    const int lastPage = 2;
    if (pageIndex == lastPage) {
      _goToDetailsScreen();
      return;
    }

    pageController.nextPage(
        duration: const Duration(seconds: 1), curve: Curves.decelerate);
  }
}
