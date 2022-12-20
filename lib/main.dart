import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathquiz/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //this line is here because of stop unwanted rebuilding widget from MediaQery class
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String primaryFontFamily = 'Inconsolata';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //background color
        backgroundColor: const Color.fromRGBO(255, 250, 240, 1),

        //  backgroundColor: const Color.fromRGBO(54, 58, 102, 1),
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(227, 90, 158, 1),
            secondary: Color.fromRGBO(190, 106, 228, 1),
            primaryContainer: Colors.green,

            // 56,61,110,1
            onBackground: Color.fromRGBO(56, 61, 110, 1) //option color
            ),
        textTheme: const TextTheme(
            headline1: TextStyle(fontFamily: primaryFontFamily),
            headline2: TextStyle(fontFamily: 'Nunito')),
      ),
      home: const WelcomeScreen(),
      // home: ProfileScreen(userName: 'Taylor', userClassNo: 4, userParentEmail: '', userAvatar: 1,),
      // home: ProfileScreen(name: 'Taylor', classNo: 4, avatarNo: 1, parentEmail: '',),
      // home: DetailsScreen(),
      // home: HomeScreen(name: '',),

    );
  }
}
