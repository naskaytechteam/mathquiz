import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathquiz/screens/profile_screen.dart';
import '/widgets/common_widgets/custom_button.dart';

class SettingScreen extends StatelessWidget {
  // final VoidCallback onProfileButtonClick;
  const SettingScreen({/*required this.onProfileButtonClick,*/
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.1112),
      child: Column(
        children: [
          _gap(height * 0.03422),
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
          _gap(height * 0.04737),
          _buildCustomButton(height, width, 'Your Profile',context),
          _gap(height * 0.03158),
          _buildCustomButton(height, width, 'App Version',context),
          _gap(height * 0.03158),
          _buildCustomButton(height, width, 'Privacy Policy',context),
          _gap(height * 0.033),
          SizedBox(
            // height: 80,
            height: height * 0.1053,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShareContainer(
                    height,
                    width,
                    'instagram',
                    const Color.fromRGBO(155, 89, 182, 1),
                    const Color.fromRGBO(142, 68, 173, 1)),
                _buildShareContainer(
                    height,
                    width,
                    'facebook',
                    const Color.fromRGBO(52, 152, 219, 1),
                    const Color.fromRGBO(41, 128, 185, 1)),
                _buildShareContainer(
                    height,
                    width,
                    'Whatsapp',
                    const Color.fromRGBO(46, 204, 113, 1),
                    const Color.fromRGBO(39, 174, 96, 1))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShareContainer(double height, double width, String shareOn,
      Color backgroundColor, Color shadowColor) {
    return CustomButton(
      // height: 77,
      height: height * 0.10132,
      // width: 89,
      width: width * 0.24723,
      onButtonPressed: () {},
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      child: SvgPicture.asset('assets/images/$shareOn.svg'),
    );
  }

  Widget _buildCustomButton(
      double height, double width, String buttonText,BuildContext context) {
    return CustomButton(
      // height: 70,
      height: height * 0.0922,
      width: width * 0.81945,
      // width: 295,
      buttonName: buttonText,
      textColor: Colors.black45,
      onButtonPressed: () {
        if (buttonText == 'Your Profile') {
          // onProfileButtonClick();
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return const ProfileScreen();
          }));
        }
      },
      backgroundColor: const Color.fromRGBO(236, 240, 241, 1),
      shadowColor: const Color.fromRGBO(189, 195, 199, 1),
    );
  }

  Widget _gap(double height) {
    return SizedBox(height: height);
  }
}
