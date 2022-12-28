import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '/utils/text_utils.dart';

import '../database/db_helper.dart';
import '/screens/home_screen.dart';
import '/utils/user_preferences.dart';
import '/utils/util.dart';
import '/widgets/common_widgets/custom_button.dart';

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

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _classController =
      TextEditingController(text: UserPreferences.getClass()?.toString());
  final TextEditingController _nameController =
      TextEditingController(text: UserPreferences.getName());
  final TextEditingController _parentsEmailController =
      TextEditingController(text: UserPreferences.getParentEmail());
  final TextEditingController _passwordController=TextEditingController();

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
    // final bool isSystemBarShowing = mediaQueryData.viewPadding.bottom > 0;
    return Scaffold(
      appBar: type == DetailScreenType.profileScreenType
          ? CustomAppBar(title: 'Your Profile', height: height * 0.1)
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1112),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
                  // height: height * 0.05,
                  // ),
              if (type == DetailScreenType.userDetailType)
                SizedBox(
                  height: height * 0.055,
                  width: width,
                  child: Text(
                    'Lorem Ipsum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        // fontSize: 32
                        fontSize: height * 0.04215),
                  ),
                ),
              // if (type == DetailScreenType.userDetailType)
              // SizedBox(
              // height: isSystemBarShowing ? height * 0.05 : height * 0.0,
              // ),
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
              Center(
                child: SizedBox(
                  // height: height * 0.33,
                  // height: height*0.4,
                  width: width,
                  // color: Colors.red,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          // onSubmitted: onSubmit,
                          validator: (value) => TextUtils.isEmpty(value)
                              ? 'Please Enter your Name'
                              : null,
                          onSaved: (newValue) =>
                              UserPreferences.setName(newValue!),
                          decoration: getInputDecoration(width, height, 'Name'),
                        ),
                        SizedBox(
                          // height: 20,
                          height: height * 0.0264,
                        ),
                        TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          controller: _classController,
                          // onSubmitted: onSubmit,
                          validator: (value) => TextUtils.isEmpty(value)
                              ? 'Please Enter your Class'
                              : null,
                          onSaved: (newValue) =>
                              UserPreferences.setClass(int.parse(newValue!)),
                          decoration: getInputDecoration(width, height, 'Class')
                              .copyWith(suffixIcon: _dropDownWidget(height)),
                        ),
                        SizedBox(
                          // height: 20,
                          height: height * 0.0264,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _parentsEmailController,
                          // onSubmitted: onSubmit,
                          validator: (value) =>
                              TextUtils.isEmpty(value) || !_isValidEmail(value!)
                                  ? 'Please Enter your Parent\'s Email'
                                  : null,
                          onSaved: (newValue) =>
                              UserPreferences.setParentEmail(newValue!),
                          decoration: getInputDecoration(
                              width, height, 'Parent\'s Email'),
                        ),
                        SizedBox(
                          // height: 20,
                          height: height * 0.0264,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _passwordController,
                          obscureText: true,
                          // onSubmitted: onSubmit,
                          validator: (value) =>
                              TextUtils.isEmpty(value)
                              ? 'Please Enter your Password'
                              : null,
                          // onSaved: (newValue) =>
                              // UserPreferences.setParentEmail(newValue!),
                          decoration: getInputDecoration(
                              width, height, 'Parent\'s Email'),
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

  Widget _dropDownWidget(double height) {
    return DropdownButton<int>(
      underline: const SizedBox(),
      elevation: 0,
      focusColor: Theme.of(context).colorScheme.background,
      alignment: Alignment.center,
      icon: SvgPicture.asset(
        'assets/images/dropdown.svg',
        // height: 12
        // height: height* 0.0158,
        // width: 10
        // width: width* 0.028,
      ),
      // iconSize: 20,
      iconSize: height * 0.0264,
      items: List.generate(
          DbHelper.totalClass, //totalClass
          (index) => DropdownMenuItem(
                value: index + 1,
                child: Text((index + 1).toString()),
              )),
      onChanged: (value) => _classController.text = value.toString(),
    );
  }

  InputDecoration getInputDecoration(
      double width, double height, String hintText) {
    return InputDecoration(
        prefix: SizedBox(
          width: width * 0.0667,
        ),
        hintStyle: TextStyle(
            color: const Color.fromRGBO(189, 195, 199, 1),
            // fontSize: 20,
            fontSize: height * 0.0264,
            fontWeight: FontWeight.w700),
        hintText: hintText,
        focusedBorder: _buildInputBorder(width, height),
        enabledBorder: _buildInputBorder(width, height),
        errorBorder: _buildInputBorder(width, height, Colors.red),
        border: _buildInputBorder(width, height));
  }

  InputBorder _buildInputBorder(double width, double height,
      [Color color = const Color.fromRGBO(44, 62, 80, 1)]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(height * 0.033),
        borderSide: BorderSide(color: color, width: width * 0.0084));
  }

  void _disposeAllControllers() {
    _nameController.dispose();
    _classController.dispose();
    _parentsEmailController.dispose();
    _passwordController.dispose();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  void _onClick() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserPreferences.setAvatar(_selectedAvatar);
      await Utils.hideSystemNavBar();
      _goToHomePage();
    }
  }

  bool _isValidEmail(String email) {
    final RegExp pattern = RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$');
    return pattern.hasMatch(email);
  }

  void _goToHomePage() {
    if (type == DetailScreenType.userDetailType) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      Navigator.of(context).pop();
    }
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
