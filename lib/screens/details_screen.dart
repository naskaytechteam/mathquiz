import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/screens/home_screen.dart';
import '/utils/user_preferences.dart';
import '/utils/util.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_textfield.dart';

enum DetailScreenType {
  userDetailType,
  profileScreenType,
}

class DetailsScreen extends StatefulWidget {
  static const String routeName = '/screens/userDetails';

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  static const _defaultSelectedAvatar = 1;

  final TextEditingController _classController =
      TextEditingController(text: UserPreferences.getClass()?.toString());
  final TextEditingController _nameController =
      TextEditingController(text: UserPreferences.getName());
  final TextEditingController _parentsEmailController =
      TextEditingController(text: UserPreferences.getParentEmail());

  late DetailScreenType type;
  int _selectedAvatar = UserPreferences.getAvatar() ?? _defaultSelectedAvatar;

  @override
  Widget build(BuildContext context) {
    type = ModalRoute.of(context)?.settings.arguments as DetailScreenType;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = mediaQueryData.size;
    final double height = size.height;
    final double width = size.width;
    final Color backgroundColor = Theme.of(context).colorScheme.background;
    final TextStyle textStyle =
        TextStyle(fontSize: height * 0.0211, fontWeight: FontWeight.w900);
    final bool isSystemBarShowing = mediaQueryData.viewPadding.bottom > 0;

    return Scaffold(
      appBar: type == DetailScreenType.profileScreenType
          ? AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  size: height * 0.05264,
                  color: const Color.fromRGBO(231, 76, 60, 1),
                ),
              ),
              centerTitle: true,
              title: Text('Your Profile',
                  style: TextStyle(
                      color: Colors.black,
                      // fontSize: 18,
                      fontSize: height * 0.02369,
                      fontWeight: FontWeight.w600)),
            )
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1112),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: isSystemBarShowing ? height * 0.05 : height * 0.1106,
              ),
              if (type == DetailScreenType.userDetailType)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.014),
                  child: SizedBox(
                    height: height * 0.1158,
                    width: width,
                    child: Text(
                      'Lorem Ipsum Dolar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: height * 0.04215),
                    ),
                  ),
                ),
              SizedBox(
                height: height * 0.01449,
              ),
              SizedBox(
                height: height * 0.029,
                width: width,
                child: Text(
                  'Enter your Details',
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: height * 0.01975,
              ),
              Align(
                child: SizedBox(
                  // height: height * 0.33,
                  // height: height*0.4,
                  width: width,
                  // color: Colors.red,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Name',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value == '') {
                              print('name == bull');
                              return 'Please Enter your Name';
                            }
                            return null;
                          },
                          // onSubmit: _onSubmit,
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
                          validator: (value) {
                            if (value == '') {
                              print('Class == bull');
                              return 'Please Select your Class';
                            }
                            return null;
                          },
                          onClassSelected: _onClassSelected,
                          isClassTextField: true,
                        ),
                        SizedBox(
                          // height: 20,
                          height: height * 0.0264,
                        ),
                        CustomTextField(
                          hintText: 'Parent\'s Email',
                          validator: (value) {
                            if (value == null) {
                              print('email == bull');
                              return 'Please Enter your Parent Email';
                            } else if (!_isValidEmail(value)) {
                              print('Email is Not Valid');
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                          controller: _parentsEmailController,
                          // onSubmit: _onSubmit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.0395,
              ),
              SizedBox(
                height: height * 0.029,
                width: width,
                child: Text(
                  'Choose your Avatar',
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: height * 0.01975,
              ),
              SizedBox(
                height: height * 0.1053,
                width: width,
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
                height: height * 0.0659,
              ),
              CustomButton(
                onButtonPressed: _onClick,
                buttonName: 'CONTINUE',
                height: height * 0.0922,
                width: width * 0.817,
              ),
              SizedBox(
                height: height * 0.0659,
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  void _onClassSelected(int? value) {
    setState(() {
      _classController.text = value.toString();
    });
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
    if (name.isNotEmpty && cNo.isNotEmpty && _isValidEmail(parentEmail)) {
      int classNo = int.parse(cNo);
      _saveUserDetails(name, classNo, parentEmail);
      await Utils.hideSystemNavBar();
      _goToHomePage();
    }
  }

  bool _isValidEmail(String email) {
    final RegExp pattern = RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$');
    return pattern.hasMatch(email);
  }

  void _goToHomePage() {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  Widget _buildAvatar(
      int avatarNo, double height, double width, Color backgroundColor) {
    bool isAvatarSelected = _selectedAvatar == avatarNo;
    return Stack(
      children: [
        Container(
          height: height * 0.0922,
          width: width * 0.1945,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isAvatarSelected
                  ? Border.all(
                      color: const Color.fromRGBO(46, 204, 113, 1),
                      width: width * 0.0112)
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
