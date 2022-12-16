import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/setting_screen.dart';
import '../widgets/homescreenwidgets/class_screen.dart';
import '../widgets/homescreenwidgets/ranking_screen.dart';

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
    const RankingScreen(),
    const SettingScreen()
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
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/firsticon.svg',
                    color: bottomNavBarIconColor(iconIndex: 0)),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/thirdicon.svg',
                    color: bottomNavBarIconColor(iconIndex: 1)),
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

  Color bottomNavBarIconColor({required int iconIndex}) {
    return _screenIndex == iconIndex
        ? const Color.fromRGBO(231, 76, 60, 1)
        : const Color.fromRGBO(211, 211, 211, 1);
  }
}
