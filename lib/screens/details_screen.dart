import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_textfield.dart';
import '/screens/home_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String? name;
  final int? classNo;
  final String? parentEmail;
  final int? avatarNo;

  const DetailsScreen(
      {this.name, this.classNo, this.parentEmail, this.avatarNo, Key? key})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  static const _defaultSelectedAvatar = 1;
  int selectedAvatar = _defaultSelectedAvatar;
  TextEditingController classController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController parentsEmailController = TextEditingController();

  void _disposeAllControllers() {
    nameController.dispose();
    classController.dispose();
    parentsEmailController.dispose();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

// This method is for its subclass (for override)
  AppBar? appBar(double height) {
    return null;
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
      appBar: appBar(height),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            // horizontal: 40
            horizontal: width * 0.1112),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gap(height),
              buildTextWidget(height, width, nunitoFontFamily),
              secondGap(height),
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
                controller: nameController,
                onSubmit: _onSubmit,
                fontFamily: nunitoFontFamily,
              ),
              SizedBox(
                // height: 20,
                height: height * 0.0264,
              ),
              CustomTextField(
                hintText: 'Class',
                controller: classController,
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
                controller: parentsEmailController,
                onSubmit: _onSubmit,
                fontFamily: nunitoFontFamily,
              ),
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
              thirdGap(height),
              CustomButton(
                onButtonPressed: onClick,
                buttonName: buttonName(),
                height: height * 0.0922,
                width: width * 0.817,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget thirdGap(double height) {
    return SizedBox(
      // height: 50,
      height: height * 0.0659,
    );
  }

  String buttonName() {
    return 'CONTINUE';
  }

  void _onSubmit(String value) async {
    await removeSystemNavBar();
  }

  void _onClassSelected(int? value) {
    setState(() {
      classController.text = value.toString();
    });
  }

  Future<void> removeSystemNavBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
  }

  void onClick() async {
    String name = nameController.value.text;
    String cNo = classController.value.text;
    String parentEmail = parentsEmailController.value.text;
    if (name != '' && cNo != '' && parentEmail != '') {
      int classNo = int.parse(cNo);
      bool hasUserDetailsSavedSuccessfully = await _saveUserDetails(
          name, classNo, parentEmail, selectedAvatar);

      if (hasUserDetailsSavedSuccessfully) {
        log('user details has successfully stored in memory $hasUserDetailsSavedSuccessfully');
        await removeSystemNavBar();
        _goToHomePage(name, classNo, parentEmail);
      }
    }
  }
  Future<bool> _saveUserDetails(String name,int userClass,String  parentEmail,int avatarNo)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool hasNameSavedSuccessfully =
        await sharedPreferences.setString('userName', name);
    bool hasClassSavedSuccessfully =
        await sharedPreferences.setInt('classNo', userClass);
    bool hasAvatarSavedSuccessfully =
        await sharedPreferences.setInt('avatarNo', avatarNo);
    bool hasParentEmailSavedSuccessfully =
        await sharedPreferences.setString('parentEmail', parentEmail);

    return hasNameSavedSuccessfully == true &&
        hasClassSavedSuccessfully == true &&
        hasAvatarSavedSuccessfully == true &&
        hasParentEmailSavedSuccessfully == true;
  }

// This method is for its subclass (for override)
  Widget gap(double height) {
    return SizedBox(
      height: height * 0.1106,
    );
  }

// This method is for its subclass (for override)
  Widget secondGap(double height) {
    return SizedBox(
      height: height * 0.01449,
    );
  }

//  This method is for its subclass (for override)
  Widget buildTextWidget(double height, double width, [String? fontFamily]) {
    return Padding(
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
              fontFamily: fontFamily,
              fontWeight: FontWeight.w900,
              // fontSize: 32
              fontSize: height * 0.04215),
        ),
      ),
    );
  }

  void _goToHomePage(String name, int classNo, String parentEmail) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return HomeScreen(
        name: name,
        userClassNo: classNo,
        avatarNo: selectedAvatar,
        parentEmail: parentEmail,
      );
    }));
  }

  Widget _buildAvatar(
      int avatarNo, double height, double width, Color backgroundColor) {
    bool isAvatarSelected = selectedAvatar == avatarNo;
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
              // highlightColor: Theme.of(context).backgroundColor,
              highlightColor: backgroundColor,
              onTap: () {
                setState(() {
                  selectedAvatar = avatarNo;
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
