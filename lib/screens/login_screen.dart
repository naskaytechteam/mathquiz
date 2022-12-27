import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _parentEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _disposeAllController() {
    _parentEmailController.dispose();
    _passwordController.dispose();
  }

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildPositionedWidget(height*0.0698, width*0.1084, '3', left: width * 0.1, top: 0),
          _buildPositionedWidget(height*0.0461, width*0.0723, '7',
              top: 0, left: 0, right: width * 0.05),
          _buildPositionedWidget(height*0.0658, width*0.1334, 'div', top: 0, right: width * 0.2),
          _buildPositionedWidget(height*0.0895, width*0.139, '2', top: 0, right: 0),
          _buildPositionedWidget(height*0.0908, width*0.1612, 'multi', top: height * 0.1, left: 0),
          _buildPositionedWidget(height*0.183, width*0.2834, '5', top: 0, bottom: 0),
          _buildPositionedWidget(height*0.079, width*0.125, '8', left: 0, bottom: height * 0.2),
          _buildPositionedWidget(height*0.18159, width*0.3834, 'add', top: 0, bottom: 0, right: 0),
          _buildPositionedWidget(height*0.0487, width*0.164, 'equal',
              left: 0, bottom: height * 0.07),
          _buildPositionedWidget(height*0.0514, width*0.0862, '4',
              right: width * 0.1, bottom: height * 0.2),
          _buildPositionedWidget(height*0.01711, width*0.0889, 'sub',
              right: width * 0.1, bottom: height * 0.1),
          _buildPositionedWidget(height*0.0672, width*0.1917, '9', right: 0, bottom: 0),
          _buildPositionedWidget(height * 0.25, width * 0.6334, 'splash_image',
              bottom: 0, left: 0, right: 0),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: width*0.1112),
              child: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.09),
                      SizedBox(
                        height: height * 0.035,
                        width: width,
                        child:  Text(
                          'Welcome to',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: height*0.0264,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                        width: width,
                        child: Text.rich(
                          TextSpan(
                              text: 'Olym',
                              style: TextStyle(
                                  fontSize: height*0.075,
                                  color:const Color.fromRGBO(231, 76, 60, 1),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                              children:const [
                                TextSpan(
                                    text: 'Math',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold))
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        child: SizedBox(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: height * 0.05),
                                CustomTextField(
                                  hintText: 'Parent\'s Email',
                                  controller: _parentEmailController,
                                  validator: (text) {
                                    return null;
                                  },
                                  onSaved: (value){
                                  },
                                ),
                                SizedBox(height: height * 0.03),
                                CustomTextField(
                                  hintText: 'Password',
                                  controller: _passwordController,
                                  validator: (text) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                  width: width,
                                  child: Text('Forgot Password',
                                      style: TextStyle(
                                        fontSize: height*0.0185,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.right),
                                ),
                                SizedBox(height: height * 0.03),
                                CustomButton(
                                  height: height * 0.09,
                                  width: width,
                                  onButtonPressed: (){
                                    _formKey.currentState?.save();
                                  },
                                  buttonName: 'LOGIN',
                                ),
                                SizedBox(height: height*0.05),
                                SizedBox(
                                  height: height * 0.03,
                                  width: width,
                                  child:  Text.rich(TextSpan(
                                      text: 'Don’t have an account? ',
                                      style: TextStyle(
                                          fontSize: height*0.0185,
                                          fontWeight: FontWeight.w700),
                                      children: const [
                                        TextSpan(
                                            text: 'Sign Up',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    231, 76, 60, 1)))
                                      ]),textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPositionedWidget(double height, double width, String imageName,
      {double? top, double? bottom, double? right, double? left}) {
    return Positioned(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
        child: SvgPicture.asset(
          'assets/images/$imageName.svg',
          height: height,
          width: width,
        ));
  }
}
