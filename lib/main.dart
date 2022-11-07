import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //this line is here because of stop unwanted rebuilding widget from MediaQery class
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String primaryFontFamily = 'Inconsolata';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: const Color.fromRGBO(54, 58, 102, 1),
        //background color
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(227, 90, 158, 1),
            secondary: Color.fromRGBO(190, 106, 228, 1),
            primaryContainer: Colors.green,

            // 56,61,110,1
            onBackground: Color.fromRGBO(56, 65, 110, 1) //option color
            ),
        textTheme: const TextTheme(
          headline1: TextStyle(fontFamily: primaryFontFamily),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
