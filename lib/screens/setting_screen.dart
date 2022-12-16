import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/common_widgets/custom_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.1112),
        child: Column(
          children: [
            SizedBox(
              // height: 26,
              height: height * 0.03422,
            ),
            SizedBox(
              height: height * 0.1,
              width: width,
              // color: Colors.red,
              child: Text.rich(
                TextSpan(
                    text: 'All Your\n',
                    style: TextStyle(
                        // fontSize: 14,
                        fontSize: height * 0.0185,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: 'Settings',
                          style: TextStyle(
                              // fontSize: 32,
                              fontSize: height * 0.0422,
                              // color: Colors.black,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
            ),
            SizedBox(
              // height: 36,
              height: height * 0.04737,
            ),
            CustomButton(
              // height: 70,
              height: height * 0.0922,
              // width: 295,
              width: width * 0.81945,
              buttonName: 'Your Profile',
              textColor: Colors.black45,

              onButtonPressed: () {},
              backgroundColor: const Color.fromRGBO(236, 240, 241, 1),
              shadowColor: const Color.fromRGBO(189, 195, 199, 1),
            ),
            // customContainer(context, 'Your Profile'),
            SizedBox(
              // height: 24,
              height: height * 0.03158,
            ),
            CustomButton(
              // height: 70,
              height: height * 0.0922,
              // width: 295,
              width: width * 0.81945,
              buttonName: 'App Version',
              textColor: Colors.black45,

              onButtonPressed: () {},
              backgroundColor: const Color.fromRGBO(236, 240, 241, 1),
              shadowColor: const Color.fromRGBO(189, 195, 199, 1),
            ),

            // customContainer(context, 'App Version'),
            SizedBox(
              // height: 24,
              height: height * 0.03158,
            ),
            CustomButton(
              // height: 70,
              height: height * 0.0922,
              // width: 295,
              width: width * 0.81945,
              buttonName: 'Privacy Policy',
              textColor: Colors.black45,
              onButtonPressed: () {},
              backgroundColor: const Color.fromRGBO(236, 240, 241, 1),
              shadowColor: const Color.fromRGBO(189, 195, 199, 1),
            ),

            // customContainer(context, 'Privacy Policy'),
            SizedBox(
              // height: 25,
              height: height * 0.033,
            ),
            SizedBox(
              // height: 80,
              height: height * 0.1053,
              // width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    // height: 77,
                    height: height * 0.10132,
                    // width: 89,
                    width: width * 0.24723,
                    onButtonPressed: () {},
                    backgroundColor: const Color.fromRGBO(155, 89, 182, 1),
                    shadowColor: const Color.fromRGBO(142, 68, 173, 1),
                    child: SvgPicture.asset('assets/images/instagram.svg'),
                  ),
                  CustomButton(
                    // height: 77,
                    height: height * 0.10132,
                    // width: 89,
                    width: width * 0.24723,
                    onButtonPressed: () {},
                    backgroundColor:const Color.fromRGBO(52, 152, 219, 1),
                    shadowColor:const Color.fromRGBO(41, 128, 185, 1),
                    child: SvgPicture.asset('assets/images/facebook.svg'),
                  ),
                  CustomButton(
                    // height: 77,
                    height: height * 0.10132,
                    // width: 89,
                    width: width * 0.24723,
                    onButtonPressed: () {},
                    backgroundColor:const Color.fromRGBO(46, 204, 113, 1),
                    shadowColor:const Color.fromRGBO(39, 174, 96, 1),
                    child: SvgPicture.asset('assets/images/whatsapp.svg'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
