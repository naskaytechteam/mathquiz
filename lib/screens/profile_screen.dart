import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/widgets/common_widgets/custom_button.dart';
import '/widgets/common_widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final int classNo;
  final int avatarNo;
  final String parentEmail;

  const ProfileScreen(
      {required this.name,
      required this.classNo,
      required this.avatarNo,
      required this.parentEmail,
      Key? key})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _classController;
  late final TextEditingController _nameController;
  late final TextEditingController _parentEmailController;
  late int _avatarNo;

  void _disposeAllControllers() {
    _classController.dispose();
    _nameController.dispose();
    _parentEmailController.dispose();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _classController = TextEditingController(text: widget.classNo.toString());
    _parentEmailController = TextEditingController(text: widget.parentEmail);
    _avatarNo = widget.avatarNo;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.chevron_left,
            // size: 40,
            size: height * 0.05264,
            // color: Colors.green,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.1112),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                // height: 36,
                height: height * 0.04737,
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
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                // height: 15,
                height: height * 0.01975,
              ),
              CustomTextField(
                  hintText: 'Name',
                  controller: _nameController,
                  textInputType: TextInputType.text),
              SizedBox(
                // height: 20,
                height: height * 0.0264,
              ),
              CustomTextField(
                hintText: 'Class',
                controller: _classController,
                textInputType: TextInputType.number,
                isClassTextField: true,
                readOnly: true,
                onClassSelected: (value) {
                  setState(() {
                    _classController.text = value.toString();
                  });
                },
              ),
              SizedBox(
                // height: 20,
                height: height * 0.0264,
              ),
              CustomTextField(
                  hintText: 'Parent\'s Email',
                  controller: _parentEmailController,
                  // onSubmit: _onSubmit,
                  textInputType: TextInputType.text),

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
                    avatar(1, height, width),
                    avatar(2, height, width),
                    avatar(3, height, width),

                  ],
                ),
              ),
              SizedBox(
                // height: 211,
                height: height * 0.1,
                // height: height * 0.27764,
              ),
              CustomButton(
                  buttonName: 'SAVE',
                  height: height * 0.0922,
                  width: width * 0.817,
                  onButtonPressed: _onClick)
            ],
          ),
        ),
      ),
    );
  }
  Widget avatar(int avatarNo, double height, double width) {
    bool isAvatarSelected = widget.avatarNo == avatarNo;
    return Stack(
      children: [
        Container(
          // height: 70,
          height: height * 0.0922,
          // width: 70,
          width: width * 0.1945,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
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
                  _avatarNo = avatarNo;
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


  void _onAvatarSelected(int avatarNo) {
    setState(() {
      _avatarNo = avatarNo;
    });
  }

  Future<void> _removeSystemBars() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
  }

  void _onClick() async {
    NavigatorState navigatorState = Navigator.of(context);
    await _removeSystemBars();
    int classNo = int.parse(_classController.value.text);
    String name = _nameController.value.text;
    String parentEmail = _parentEmailController.value.text;

    if (widget.name == name &&
        widget.classNo == classNo &&
        widget.avatarNo == _avatarNo) {
      navigatorState.pop();
    } else {
      if (name != '' && parentEmail != '') {
        bool hasUserDetailsSaved = await _saveUserDetails(
            name, classNo, parentEmail, _avatarNo);
        if (hasUserDetailsSaved) {
          navigatorState.pop({
            'userName': name,
            'classNo': classNo,
            'avatarNo': _avatarNo,
            'parentEmail': parentEmail
          });
        }
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


  // Widget avatar(int avatarNo, double height, double width) {
  //   bool isAvatarSelected = _avatarNo == avatarNo;
  //   return
  // }

  TextStyle labelStyle(double height) {
    return TextStyle(
        color: const Color.fromRGBO(189, 195, 199, 1),
        // fontSize: 20,
        fontSize: height * 0.0264,
        fontWeight: FontWeight.w700);
  }
}
