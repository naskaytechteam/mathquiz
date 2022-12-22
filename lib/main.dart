import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/screens/details_screen.dart';
import '/screens/splash_screen.dart';
import 'utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreferences.initSharedPrefs();
  //this line is here because of stop unwanted rebuilding widget from MediaQery class
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // static const String primaryFontFamily = 'Inconsolata';
  static const String primaryFontFamily = 'Nunito';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        DetailsScreen.routeName: (_) => const DetailsScreen(),
      },
      theme: ThemeData(
        fontFamily: primaryFontFamily,
        //background color

        //  backgroundColor: const Color.fromRGBO(54, 58, 102, 1),
    /*    primaryColor: Colors.blue,*/
        colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(227, 90, 158, 1),
            secondary: Color.fromRGBO(190, 106, 228, 1),
            background: Color.fromRGBO(255, 250, 240, 1) ,
            primaryContainer: Colors.green,

            // 56,61,110,1
            //what is this property used for?
            onBackground: Color.fromRGBO(56, 61, 110, 1) //option color
            ),
        /*textTheme: const TextTheme(
            headline1: TextStyle(fontFamily: primaryFontFamily),
            headline2: TextStyle(fontFamily: secondaryFontFamily)),*/
      ),
      home: const SplashScreen(),
    );
  }
}
