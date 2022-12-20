import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathquiz/utils/user_preferences.dart';

import '/screens/home_screen.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_textfield.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  static const _defaultSelectedAvatar = 1;
  int _selectedAvatar = _defaultSelectedAvatar;
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _parentsEmailController = TextEditingController();

  void _disposeAllControllers() {
    _nameController.dispose();
    _classController.dispose();
    _parentsEmailController.dispose();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final ThemeData theme = Theme.of(context);

    final String? nunitoFontFamily = theme.textTheme.headline2?.fontFamily;
    final Color backgroundColor = theme.backgroundColor;
    final TextStyle textStyle = TextStyle(
        // fontSize: 16,
        fontSize: height * 0.0211,
        fontFamily: nunitoFontFamily,
        fontWeight: FontWeight.w900);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            // horizontal: 40
            horizontal: width * 0.1112),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 84,
                height: height * 0.1106,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    // horizontal: 5
                    horizontal: width * 0.014),
                child: SizedBox(
                  // height: 88,
                  height: height * 0.1158,
                  // alignment: Alignment.center,
                  // width: 280,
                  width: width,
                  child: Text(
                    'Lorem Ipsum Dolar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily,
                        fontWeight: FontWeight.w900,
                        // fontSize: 32
                        fontSize: height * 0.04215),
                  ),
                ),
              ),
              SizedBox(
                // height: 11,
                height: height * 0.01449,
              ),
              SizedBox(
                // height: 22,
                height: height * 0.029,
                // width: 142,
                // width: width*0.3945,
                width: width,
                child: Text(
                  'Enter your Details',
                  style: textStyle,
                  // style: TextStyle(
                  //     // fontSize: 16,
                  //     fontSize: height * 0.0211,
                  //     fontWeight: FontWeight.w900,
                  //     fontFamily: nunitoFontFamily),
                ),
              ),
              SizedBox(
                // height: 15,
                height: height * 0.01975,
              ),
              CustomTextField(
                hintText: 'Name',
                controller: _nameController,
                onSubmit: _onSubmit,
                fontFamily: nunitoFontFamily,
              ),
              SizedBox(
                // height: 20,
                height: height * 0.0264,
              ),
              CustomTextField(
                hintText: 'Class',
                controller: _classController,
                textInputType: TextInputType.number,
                readOnly: true,
                fontFamily: nunitoFontFamily,
                onClassSelected: _onClassSelected,
                isClassTextField: true,
              ),
              SizedBox(
                // height: 20,
                height: height * 0.0264,
              ),
              CustomTextField(
                  hintText: 'Parent\'s Email',
                  controller: _parentsEmailController,
                  onSubmit: _onSubmit,
                  fontFamily: nunitoFontFamily),
              SizedBox(
                // height: 30,
                height: height * 0.0395,
              ),
              SizedBox(
                // height: 22,
                height: height * 0.029,
                // width: 153,
                // width: width* 0.425,
                width: width,
                child: Text(
                  'Choose your Avatar',
                  style: textStyle,
                ),
              ),
              SizedBox(
                // height: 15,
                height: height * 0.01975,
              ),
              SizedBox(
                // height: 80,
                height: height * 0.1053,
                width: width,
                // color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAvatar(1, height, width, backgroundColor),
                    _buildAvatar(2, height, width, backgroundColor),
                    _buildAvatar(3, height, width, backgroundColor),
                  ],
                ),
              ),
              SizedBox(
                // height: 50,
                height: height * 0.0659,
              ),
              CustomButton(
                onButtonPressed: _onClick,
                buttonName: 'CONTINUE',
                height: height * 0.0922,
                width: width * 0.817,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(String value) async {
    await _removeSystemNavBar();
  }

  void _onClassSelected(int? value) {
    setState(() {
      _classController.text = value.toString();
    });
  }

  Future<void> _removeSystemNavBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
  }

  void _saveUserDetails(String name, int userClass, String parentEmail) {
    UserPreferences.setName(name);
    UserPreferences.setClass(userClass);
    UserPreferences.setParentEmail(parentEmail);
    UserPreferences.setAvatar(_selectedAvatar);
  }

  void _onClick() async {
    String name = _nameController.value.text;
    String cNo = _classController.value.text;
    String parentEmail = _parentsEmailController.value.text;
    if (name.isNotEmpty && cNo.isNotEmpty && parentEmail.isNotEmpty) {
      int classNo = int.parse(cNo);
      _saveUserDetails(name, classNo, parentEmail);
      await _removeSystemNavBar();
      _goToHomePage();
    }
  }

  void _goToHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const HomeScreen();
    }));
  }

  Widget _buildAvatar(
      int avatarNo, double height, double width, Color backgroundColor) {
    bool isAvatarSelected = _selectedAvatar == avatarNo;
    return Stack(
      children: [
        Container(
          // height: 70,
          height: height * 0.0922,
          // width: 70,
          width: width * 0.1945,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isAvatarSelected
                  ? Border.all(
                      color: const Color.fromRGBO(46, 204, 113, 1),
                      // width: 4
                      width: width * 0.0112
                      // width: height* 0.0053
                      )
                  : null),
          child: InkWell(
              highlightColor: backgroundColor,
              onTap: () {
                setState(() {
                  _selectedAvatar = avatarNo;
                });
              },
              child: SvgPicture.asset('assets/images/avatar$avatarNo.svg')),
        ),
        Visibility(
          visible: isAvatarSelected,
          child: Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset('assets/images/selected.svg')),
        )
      ],
    );
  }
}
