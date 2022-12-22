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
  static const String primaryFontFamily = 'Nunito';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        DetailsScreen.routeName: (_) => const DetailsScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: primaryFontFamily,
        colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(227, 90, 158, 1),
            secondary: Color.fromRGBO(190, 106, 228, 1),
            background: Color.fromRGBO(255, 250, 240, 1),
            primaryContainer: Colors.green,
            onBackground: Color.fromRGBO(56, 61, 110, 1) //option color
            ),
      ),
      home: const SplashScreen(),
    );
  }
}
