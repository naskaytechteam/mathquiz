import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './provider/quiz_provider.dart';
import './provider/time_provider.dart';
import './screens/ques_type_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //this line is here because of stop unwanted rebuilding widget from MediaQery class
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider<QuizProvider>.value(value: QuizProvider()),
      ChangeNotifierProvider<TimeProvider>.value(value: TimeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String primaryFontFamily = 'Inconsolata';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(fontFamily: primaryFontFamily),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
