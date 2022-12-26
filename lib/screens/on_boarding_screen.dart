import 'package:flutter/material.dart';
import '/widgets/on_boarding_screen_widgets/on_boarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/screens/details_screen.dart';
import '/widgets/common_widgets/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/screens/onboarding";

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  static const _totalPages = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.809,
                width: width,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (nextPageIndex) {
                    _pageIndex = nextPageIndex;
                  },
                  children: [
                    OnBoardingPage(
                        imageNo: 1,
                        imageHeight: height * 0.4145,
                        imageWidth: width * 0.7584,
                        firstGapHeight: height * 0.0593,
                        secondTextContainerHeight: height * 0.0869,
                        firstText: 'Learning is fun \nnow',
                        secondText:
                            'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.'),
                    OnBoardingPage(
                      imageNo: 2,
                      imageHeight: height * 0.45265,
                      imageWidth: width * 0.778,
                      isSecondPage: true,
                      firstText: 'Mockup tests for Olympiad',
                      secondText:
                          'Lorem ipsum dolor  consectetur  sed do eiusmod  ut labore et dolore aliqua.',
                      secondTextContainerHeight: height * 0.1158,
                      firstGapHeight: height * 0.025,
                    ),
                    OnBoardingPage(
                      imageNo: 3,
                      imageHeight: height * 0.40265,
                      imageWidth: width * 0.7028,
                      firstText: 'Custom Math problems',
                      secondText:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      secondTextContainerHeight: height * 0.0869,
                      firstGapHeight: height * 0.0694,
                      isThirdScreen: true,
                    ),
                  ],
                ),
              ),
              //todo this indicator is not dynamic(responsible)

              SizedBox(
                height: height * 0.02,
                width: width,
                child: Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _totalPages,
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
                onButtonPressed: _onButtonPressed,
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
    Navigator.of(context).pushNamed(DetailsScreen.routeName,
        arguments: DetailScreenType.userDetailType);
  }

  void _onButtonPressed() {
    //_totalPages-1 because pageIndex starts from 0
    if (_pageIndex == _totalPages - 1) {
      _goToDetailsScreen();
      return;
    }

    _pageController.nextPage(
        duration: const Duration(seconds: 1), curve: Curves.decelerate);
  }
}
