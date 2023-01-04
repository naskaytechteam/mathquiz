import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/setting_screen.dart';
import '../widgets/homescreenwidgets/class_screen.dart';
import '../widgets/homescreenwidgets/ranking_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/screens/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _screenIndex = 0;
  static const _totalHomeScreens = 3;
  late TabController tabController =
      TabController(length: _totalHomeScreens, vsync: this);
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
      body: _screens[_screenIndex],
      bottomNavigationBar: SizedBox(
          height: height * 0.13158,
          width: width,
          child: TabBar(
              overlayColor: MaterialStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.background),
              onTap: (index) {
                setState(() {
                  _screenIndex = index;
                });
              },
              controller: tabController,
              //todo how to make indicator circular
              indicator: UnderlineTabIndicator(
                  borderSide: const BorderSide(
                    width: 9,
                    color: Colors.red,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: width * 0.07)),
              tabs: [
                Tab(
                  icon: SvgPicture.asset('assets/images/first_nav_icon.svg',
                      height: height*0.03,
                      color: _bottomNavBarIconColor(iconIndex: 0)),
                ),
                Tab(
                  icon: SvgPicture.asset('assets/images/second_nav_icon.svg',
                      height: height*0.03,
                      color: _bottomNavBarIconColor(iconIndex: 1)),
                ),
                Tab(
                    icon: Icon(Icons.settings_outlined,
                        size: height * 0.04,
                        color: _bottomNavBarIconColor(iconIndex: 2)))
              ])),
    );
  }

  Color _bottomNavBarIconColor({required int iconIndex}) {
    return _screenIndex == iconIndex
        ? const Color.fromRGBO(231, 76, 60, 1)
        : const Color.fromRGBO(211, 211, 211, 1);
  }
}
