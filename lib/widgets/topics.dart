import 'package:flutter/material.dart';
import '/widgets/common_widgets/custom_app_bar.dart';
import '/provider/template_factory.dart';
import '/screens/ques_screen.dart';
import '../model/question.dart';

class Topics extends StatelessWidget {
  final int classNo;
  final List<int> quesTypeList;

  const Topics({required this.classNo, required this.quesTypeList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Class $classNo',
        height: height * 0.1,
      ),
      body: Column(
        children: [
          SizedBox(
            // height: 36,
            height: height * 0.04737,
          ),
          Container(
            // height: 22,
            height: height * 0.029,
            width: width,
            padding: EdgeInsets.only(left: /*40*/ width * 0.1112),
            child: Text(
              'Topics',
              style: TextStyle(
                  // fontSize: 16,
                  fontSize: height * 0.0211,
                  fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            // height: 15,
            height: height * 0.01975,
          ),
          SizedBox(
            height: height * 0.75,
            width: width,
            // color: Colors.red,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: quesTypeList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 21,
                  // mainAxisSpacing: 20,
                  // mainAxisExtent: 180,
                  // childAspectRatio: 138 / 150
                  // mainAxisExtent: 163
                  mainAxisExtent: height * 0.21448
                  // mainAxisExtent: 6
                  ),
              padding: EdgeInsets.only(
                  left: /*40*/ width * 0.1112, right: /*19*/ width * 0.0528),
              // scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                // bool isClassSelected = this.yourClass == index + 1;
                return Container(
                  child: Column(
                    children: [
                      Align(
                        child: InkWell(
                          onTap: () async {
                            // setState(() {
                            //   yourClass = index + 1;
                            // });
                            TemplateType templateType =
                                TemplateType.values[index];
                            List<Question> questions = await TemplateFactory()
                                .generateQuestions(templateType);
                            if(questions.length>0){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return QuesScreen(
                                    templateType: templateType,
                                    questions: questions);
                              }));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // height: 117,
                            height: height * 0.15395,
                            margin:
                                EdgeInsets.only(right: /*21*/ width * 0.05834),
                            // width: 138,
                            width: width * 0.38334,
                            decoration: BoxDecoration(
                                color: /*isClassSelected
                                    ?const Color.fromRGBO(241, 196, 15, 1)
                                    :*/
                                    Color.fromRGBO(236, 240, 241, 1),
                                borderRadius: BorderRadius.circular(
                                    // 25
                                    height * 0.033),
                                boxShadow: [
                                  BoxShadow(
                                      color: /*isClassSelected
                                          ? Color.fromRGBO(242, 176, 16, 1)
                                          :*/
                                          Color.fromRGBO(189, 195, 199, 1),
                                      offset: Offset(
                                          0,
                                          // 7
                                          height * 0.0093))
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        // height: 11,
                        height: height * 0.01448,
                      ),
                      Container(
                        width: width,
                        // color: Colors.red,
                        margin: EdgeInsets.only(right: /*21*/ width * 0.05834),
                        alignment: Alignment.center,
                        // height: 15,
                        height: height * 0.01975,
                        child: Text(TemplateType.values[index].name),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
