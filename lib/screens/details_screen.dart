import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_textfield.dart';
import '/screens/home_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  static const _defaultSelectedAvatar = 1;
  int _selectedAvatar = _defaultSelectedAvatar;
  final TextEditingController _selectedClass = TextEditingController();
  final TextEditingController _name = TextEditingController();

  void _disposeAllControllers() {
    _name.dispose();
    _selectedClass.dispose();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
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
                  width: width
                  /**0.778*/,
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
                  style: TextStyle(
                      // fontSize: 16,
                      fontSize: height * 0.0211,
                      fontWeight: FontWeight.w900,
                      fontFamily:
                          Theme.of(context).textTheme.headline2?.fontFamily),
                ),
              ),
              SizedBox(
                // height: 15,
                height: height * 0.01975,
              ),
              CustomTextField(
                  hintText: 'Name',
                  controller: _name,
                  textInputType: TextInputType.text),

              SizedBox(
                // height: 20,
                height: height * 0.0264,
              ),
              CustomTextField(
                hintText: 'Class',
                controller: _selectedClass,
                textInputType: TextInputType.number,
                onClassSelected: _onClassSelected,
                isClassTextField: true,
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
                  style: TextStyle(
                      // fontSize: 16,
                      fontSize: height * 0.0211,
                      fontFamily:
                          Theme.of(context).textTheme.headline2?.fontFamily,
                      fontWeight: FontWeight.w900),
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
                    _buildAvatar(1, height, width),
                    _buildAvatar(2, height, width),
                    _buildAvatar(3, height, width),
                  ],
                ),
              ),
              SizedBox(
                // height: 50,
                height: height * 0.0659,
              ),
              CustomButton(onButtonPressed: _onClick,buttonName: 'CONTINUE',)

            ],
          ),
        ),
      ),
    );
  }

  void _onClassSelected(int? value) {
    setState(() {
      _selectedClass.text = value.toString();
    });
  }

  Future<void> _removeSystemNavBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
  }

  Future<bool> _saveUserDetails(String name, int userClass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool hasNameSavedSuccessfully =
        await sharedPreferences.setString('userName', name);
    bool hasClassSavedSuccessfully =
        await sharedPreferences.setInt('classNo', userClass);
    bool hasAvatarSavedSuccessfully =
        await sharedPreferences.setInt('avatarNo', _selectedAvatar);

    return hasNameSavedSuccessfully == true &&
        hasClassSavedSuccessfully == true &&
        hasAvatarSavedSuccessfully == true;
  }

  void _onClick() async {
    NavigatorState navigatorState = Navigator.of(context);
    String name = _name.value.text;
    int classNo = int.parse(_selectedClass.value.text);
    if (name != '' && classNo > 0) {
      bool hasUserDetailsSavedSuccessfully = await _saveUserDetails(name, classNo);

      if (hasUserDetailsSavedSuccessfully) {
        log('user details has successfully stored in memory $hasUserDetailsSavedSuccessfully');
        await _removeSystemNavBar();

        navigatorState.pushReplacement(MaterialPageRoute(builder: (_) {
          return const HomeScreen();
        }));
      }
    }
  }

  Widget _buildAvatar(int avatarNo, double height, double width) {
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
                      color:const Color.fromRGBO(46, 204, 113, 1),
                      // width: 4
                      width: width * 0.0112
                      // width: height* 0.0053
                      )
                  : null),
          child: InkWell(
              highlightColor: Theme.of(context).backgroundColor,
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
