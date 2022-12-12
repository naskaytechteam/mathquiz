import 'package:flutter/material.dart';
import 'package:mathquiz/screens/home_screen.dart';
import 'package:mathquiz/widgets/onboardingscreenwidgets/page1.dart';
import 'package:mathquiz/widgets/onboardingscreenwidgets/page2.dart';
import 'package:mathquiz/widgets/onboardingscreenwidgets/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
              Container(
                height: height * 0.808,
                width: width,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (a) {
                    pageIndex = a;
                  },
                  children: [Page1(onSkip: onSkip,), Page2(onSkip: onSkip,), Page3()],
                ),
              ),
              Container(
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
              CustomButton(onButtonPressed: onButtonPressed)
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
    const int lastPage = 2;
    if (pageIndex == lastPage) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              pageBuilder: (_, animation, secondAnimation) {
                return const DetailsScreen();
              },
              transitionsBuilder: (_, animation, secondAnimation, widget) {
                Animation<Offset> an = Tween<Offset>(
                        begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(animation);
                return SlideTransition(
                  position: an,
                  child: widget,
                );
              }));
      return;
    }

                  pageController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.decelerate);
                },
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  width: width * 0.817,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(231, 76, 60, 1),
                      borderRadius: BorderRadius.circular(height * 0.0352),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 9),
                            color: Color.fromRGBO(192, 57, 43, 1))
                      ]),
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 250, 240, 1),
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily,
                        fontWeight: FontWeight.w900,
                        fontSize: height * 0.0281),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSkip(){
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration:const Duration(milliseconds: 800),
            pageBuilder: (_, animation, secondAnimation) {
              return const HomeScreen();
            },
            transitionsBuilder:
                (_, animation, secondAnimation, widget) {
              Animation<Offset> an = Tween<Offset>(
                  begin:const Offset(1.0, 0.0), end: Offset.zero)
                  .animate(animation);
              return SlideTransition(
                position: an,
                child: widget,
              );
            }));
  }
}
