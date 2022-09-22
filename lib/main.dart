import 'package:flutter/material.dart';
import 'package:mathquiz/model/quiz_data.dart';
import 'package:mathquiz/provider/quiz_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<QuizProvider>.value(value: QuizProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    List<QuizData> list = quizProvider.quizData;

    return Scaffold(
      body: Container(
        color: Colors.red,
        margin: const EdgeInsets.only(top: 60),
        child: list.isNotEmpty
            ? Column(
                children: [
                  Text(
                    list[_index].ques,
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    list[_index].options[0].toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    list[_index].options[1].toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    list[_index].options[2].toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    list[_index].options[3].toString(),
                    style: const TextStyle(fontSize: 40),
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(onPressed: (){

          }),
          FloatingActionButton(onPressed: (){
            print('length -> ${list.length} index -> $_index');
            if(_index<list.length-1){
              setState(() {
                _index++;
              });
            }
          })
        ],
      ),
    );
  }
}
