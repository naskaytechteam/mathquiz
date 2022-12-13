import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathquiz/widgets/common_widgets/custom_button.dart';
import 'package:mathquiz/widgets/common_widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final int classNo;
  final int avatarNo;

  const ProfileScreen(
      {required this.name,
      required this.classNo,
      required this.avatarNo,
      Key? key})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _selectedClass;

  late final TextEditingController _name;

  void _disposeAllControllers() {
    _selectedClass.dispose();
    _name.dispose();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  @override
  void initState() {
    _name = TextEditingController(text: widget.name);
    _selectedClass = TextEditingController(text: widget.classNo.toString());

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
          onTap: (){
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
                fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.1112),
        child: Column(
          children: [
            SizedBox(
              // height: 36,
              height: height * 0.04737,
            ),
            Container(
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
            CustomTextField(hintText: 'Class', controller: _selectedClass, textInputType: TextInputType.number,isClassTextField: true,onClassSelected: (value){
              setState(() {
                _selectedClass.text=value.toString();
              });
            },),
            SizedBox(
              // height: 30,
              height: height * 0.0395,
            ),
            Container(
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
                  avatar(1, height, width),
                  avatar(2, height, width),
                  avatar(3, height, width),
                ],
              ),
            ),
            SizedBox(
              // height: 211,
              height: height * 0.27764,
            ),
            CustomButton(
                buttonName: 'SAVE',
                height: height * 0.0922,
                width: width * 0.817,
                onButtonPressed: () {})
          ],
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
                      color: Color.fromRGBO(46, 204, 113, 1),
                      // width: 4
                      width: width * 0.0112
                      // width: height* 0.0053
                      )
                  : null),
          child: InkWell(
              highlightColor: Theme.of(context).backgroundColor,
              onTap: () {
                setState(() {
                  //selectedAvatar = avatarNo;
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

  TextStyle labelStyle(double height) {
    return TextStyle(
        color: const Color.fromRGBO(189, 195, 199, 1),
        // fontSize: 20,
        fontSize: height * 0.0264,
        fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
        fontWeight: FontWeight.w700);
  }
}
