import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/setting_screen.dart';
import '../widgets/homescreenwidgets/class_screen.dart';
import '../widgets/homescreenwidgets/ranking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;

  final List<Widget> _screens = [
    ClassScreen(),
    const RankingScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: SingleChildScrollView(child: _screens[_screenIndex]),
      bottomNavigationBar: SizedBox(
        // height: 100,
        height: height * 0.13158,
        width: width,
        child: BottomNavigationBar(
          currentIndex: _screenIndex,
          onTap: (index) {
            setState(() {
              _screenIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/firsticon.svg',
                    color: _bottomNavBarIconColor(iconIndex: 0)),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/thirdicon.svg',
                    color: _bottomNavBarIconColor(iconIndex: 1)),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/setting.svg',
                  color: _bottomNavBarIconColor(iconIndex: 2),
                ),
                label: '')
          ],
        ),
      ),
    );
  }

  // void _onProfileButtonClick() async {
  //   dynamic result =
  //       await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return const ProfileScreen();
  //   }));
  //   if (result != null) {
  //     setState(() {
  //       _setNewUserData(result);
  //     });
  //   }
  // }

  // void _setNewUserData(Map result) {
  //   _name = result['userName'];
  //   _classNo = result['classNo'];
  //   _avatarNo = result['avatarNo'];
  //   _parentEmail = result['parentEmail'];
  //   _replaceOldDetailsWithNew();
  // }

//need to change
//   void _replaceOldDetailsWithNew() {
//     _screens[0] = ClassScreen(
//         name: _name,
//         userClassNo: _classNo,
//         avatarNo: _avatarNo,
//         onProfileButtonClick: _onProfileButtonClick);
//   }

  Color _bottomNavBarIconColor({required int iconIndex}) {
    return _screenIndex == iconIndex
        ? const Color.fromRGBO(231, 76, 60, 1)
        : const Color.fromRGBO(211, 211, 211, 1);
  }
}
