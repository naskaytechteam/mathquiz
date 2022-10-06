import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathquiz/provider/time_provider.dart';
import '../model/ques_tenp.dart';
import '/widgets/options.dart';
import '/provider/quiz_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/quiz_screen_app_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;

  @override
  void initState() {
    Provider.of<TimeProvider>(context, listen: false).startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    QuizProvider provider = Provider.of<QuizProvider>(context, listen: false);

    QuestionTemplate? quesTemp = provider.getQuestionTemplateForIndex(_index);

    return Scaffold(
      body: Selector<TimeProvider, bool>(
        selector: (_, value) {
          return value.isTimeFinished;
        },
        builder: (BuildContext context, value, Widget? child) {
          if (value) {
            return SizedBox(
              child: Center(
                child: Text(
                    'Your score is ${provider.score} out of ${provider.quesTemplateList.length}',
                    style: const TextStyle(fontSize: 40)),
              ),
            );
          }
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: quesTemp != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _gap(
                          height * 0.06,
                        ),
                        const QuizScreenAppBar(),
                        _gap(
                          height * 0.06,
                        ),
                        Text('Question ${_index + 1}'),
                        _gap(height * 0.02),
                        _question(height, width, quesTemp.ques),
                        _gap(height * 0.03),
                        Align(
                          alignment: Alignment.center,
                          child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Image.asset('assets/background1.png',
                                  width: width, fit: BoxFit.fitHeight)),
                        ),
                        _gap(height * 0.02),
                        Options(
                            optionSelected: _optionSelected, quizData: quesTemp)
                      ],
                    )
                  : const Center(
                      child: Text(
                      'No Questions found ',
                      style: TextStyle(fontSize: 30),
                    )));
        },
      ),
    );
  }

  void _optionSelected(int selectedOption, int answer) {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: false);
    _checkAnswer(selectedOption, answer, quizProvider);
    _increaseIndex(quizProvider);
  }

  void _increaseIndex(QuizProvider quizProvider) {
    if (_index < quizProvider.quesTemplateList.length - 1) {
      setState(() {
        _index++;
      });
      return;
    }
    _showDialogBox(quizProvider);
  }
  void _showDialogBox(QuizProvider quizProvider){
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
              child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                  child: Text(
                    'Your score is ${quizProvider.score} out of ${quizProvider.quesTemplateList.length}',
                    style: const TextStyle(fontSize: 40),
                  )));
        });
  }

  void _checkAnswer(int selectedOption, int answer, QuizProvider quizProvider) {
    if (selectedOption == answer) {
      quizProvider.increaseScore();
      return;
    }
  }

  Widget _gap(double height) {
    return SizedBox(height: height);
  }

  Widget _question(double height, double width, String ques) {
    return SizedBox(
      height: height * 0.2,
      width: width,
      child: AutoSizeText(
        ques,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
      ),
    );
  }
}

/*

Ques 1. Find the difference between the greatest and the least 5-digit
         number that can be written using the digits 6,2,7,4,3 each only once     FORMULA :-> (ascending and descending order)

Ques 2. To stitch a shirt 2m 15cm cloth is needed. Out of 40m cloth, how
          many shirts can be stitched and how much cloth will remain ?            FORMULA :-> V3/V1.V2

Ques 4. Kirti bookstore sold books worth Rs 10000 in the first week of June
            and books worth Rs 20000 in the second week of the month. How
            much was the sale for two weeks together? In which week was
            the sale greater and by how much ?                                   FORMULA :-> VI+V2....... (we should avoid questions like these)

Ques 5. In an election, the successful candidate registered 593839 votes and his
           nearest rival secured 248374 votes . By what margin
           did the successful candidate win the election ?                          FORMULA :-> V1-V2 (V1 should be greater than V2) (It is a named/real life problem so will need to differentiate between those)

Ques 6. A book exhibition was held for four days in a school. The number
          of ticket sold at te counter on the first, second, third and final
          day was respectively 1094,1812,2050 and 2751 . Find the total           FORMULA :-> V1+V2+V3+V4
          number of tickets sold on all the four days

Ques 7.   A number is divisible by both 5 and 12 . By which other number
            will that number be always divisible ? :-> 3.4                        FORMULA :-> --------------

stQues 8.   A number is divisible  by 12 . By what other numbers will
              that number be divisible ?                                              FORMULA :->  we have to take List<int> for this

Ques 9.   Renu purchases two bags of fertiliser of weights 75kg and 69 kg .
              find the maximum value of weight which can measure the weight
              of the fertiliser exact number of times :-> 3.7                       FORMULA :-> (HCF question)

Ques 10.  Three boys step off together from the same spot. Their steps
            measure 63 cm.  70cm and 77 cm respectively . What is the minimum
            distance each should cover so that all can cover the distance in      FORMULA :-> (LCM question)
            complete steps?

Ques 11.  The length , breath and height of a room are 825 cm ,675cm and 450 cm
            respectively. Find the longest tape which can measure the three        FORMULA :-> (HCF question)
            dimensions of the roo m exactly

Ques 12.   Determine the smallest 3 digit number which is exactly divisible       FORMULA :->
              by 6,8,12

Ques 13.   The traffic lights at three different road crossings change
              after every 48 seconds ,72 seconds and 108 seconds respectively .
               If they change simultaneously at 7 a.m. at what time will they     FORMULA :-> (LCM question)
               change simultaneously again?

Ques 14.   Three tankers contain 403 litres , 434 litres and 465 litres of
              diesel respectively, Find the maximum capacity of a container       FORMULA :-> (LCM question)
              that can measure the diesel of the three containers exact
              number of times.

Ques 15     Find the least number which when divided by 6,15,and 18 leave         (get LCM and add 5[remainder]in that)
              remainder 5 in each

Ques 16.    (Friction question):-> Ramesh had 20 pencils, Sheela had 50
            pencils and Jamaal had 80 pencils . After 4 months, Ramesh used
            up 10 pencils, Sheela used up 25 pencils and Jamaal used up 40
            pencils. What fraction did each use up? Check if each has used up
            equal fraction of her/his pencils?  :-> 7.3

Ques 17. In a class A of 25 students , 20 passed with 60% or more marks
            in another class B of 30 students , 24 passed with 60%                  Fraction question
            or more marks. In which class was a greater fraction
            of students getting with 60% or more marks :-> 7.4

Ques 18.   Radhika's mother gave her Rs 10.50 and her father gave her
            Rs 15.80 find the total amount given to Radhika by the parents:->8.5  FORMULA :->V1.V2+V3.V4

Ques 19.    Ravi purchased 5kg 400g rice, 2kg 20g sugar and 10kg 850g
               flour Find the total weight of his purchases.                      FORMULA :-> ((V2+V4+V6)/1000)+V1+V3+V5

Ques 20.    Sweety runs around a square park of side 75m Bulbul runs
            around a rectangular park with length 60m and breadth 45m             FORMULA :->
            Who covers less distance? :-> 10.1

Ques 21.    A room is 4 m long and 3 m 50 cm wide. How many square meters
            of carpet is needed to cover the floor of the room ? :-> 10.3           FORMULA :-> V1*V2.V3

Ques 22.   In a year, Seema earn Rs 150000 and saves Rs 50000 Find the
            ratio of money that Seema earns to the money she saves :-> 12.1       (ration question )--

Ques 23.  The weight of 72 books is 9kg. What is the weight of 40 such books     FORMULA :->

 */
