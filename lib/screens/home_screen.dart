import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/homescreenwidgets/class_screen.dart';
import '../widgets/homescreenwidgets/second_screen.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final int userClassNo;
  final int avatarNo;

  const HomeScreen(
      {required this.name,
      required this.userClassNo,
      required this.avatarNo,
      Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;
  late final List<Widget> _screens = [
    ClassScreen(
      name: widget.name,
      userClassNo: widget.userClassNo,
      avatarNo: widget.avatarNo,
    ),
    const SecondScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _screens[_screenIndex],
      bottomNavigationBar: SizedBox(
        // height: 100,
        height: height * 0.13158,
        child: BottomNavigationBar(
          currentIndex: _screenIndex,
          onTap: (index) {
            setState(() {
              _screenIndex = index;
            });
          },
          unselectedItemColor: const Color.fromRGBO(211, 211, 211, 1),
          selectedItemColor: const Color.fromRGBO(231, 76, 60, 1),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/firsticon.svg',
                  // color:this.screenIndex==0?const Color.fromRGBO(231, 76, 60, 1):Color.fromRGBO(211, 211, 211, 1)
                ),
                label: ''),
            // BottomNavigationBarItem(
            //     icon: SvgPicture.asset('assets/images/secondicon.svg'),
            //     label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/thirdicon.svg',
                  // color:this.screenIndex==1?const Color.fromRGBO(231, 76, 60, 1):Color.fromRGBO(211, 211, 211, 1)
                ),
                label: '')
          ],
        ),
      ),
    );
  }

// Future<void> hasUserDetailsGetSuccessfully() async {
//   if (await getUserDetails()) {
//     _screens = [
//       ClassScreen(
//         name: _name!,
//         userClassNo: _userClassNo!,
//         avatarNo: _avatarNo!,
//       ),
//       const SecondScreen(),
//     ];
//     setState(() {
//       _userDataGetSuccessfully = true;
//     });
//   }
// }

// Future<bool> getUserDetails() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   _name = sharedPreferences.getString('userName');
//   _userClassNo = sharedPreferences.getInt('classNo');
//   _avatarNo = sharedPreferences.getInt('avatarNo');
//   return _name != null && _userClassNo != null && _avatarNo != null;
// }
}
