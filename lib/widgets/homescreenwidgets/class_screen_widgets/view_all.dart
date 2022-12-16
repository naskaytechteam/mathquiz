import 'package:flutter/material.dart';
import '../../../provider/template_factory.dart';
import '../../topics.dart';
import '/database/db_helper.dart';
import '/widgets/common_widgets/custom_app_bar.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Take a Test',
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
              'Select a Class',
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
          Container(
            height: height * 0.75,
            // color: Colors.red,
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 21,
                  // mainAxisSpacing: 20,
                  // mainAxisExtent: 180,
                  // childAspectRatio: 137 / 170,
                  // mainAxisExtent: 187
                  mainAxisExtent: height * 0.24606
                  // childAspectRatio: width * 0.3806/height * 0.2237,

                  // mainAxisSpacing: 0
                  // mainAxisExtent: 6
                  ),
              padding: EdgeInsets.only(
                  left: /* 40*/ width * 0.1112, right: /*19*/ width * 0.0528),
              // scrollDirection: Axis.horizontal,
              itemCount: DbHelper.totalClass,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    Align(
                      child: InkWell(
                        onTap: () async {
                          NavigatorState state = Navigator.of(context);
                          int classNo = index + 1;

                          List<int> quesTypesList =
                              await TemplateFactory().getQuesTypes(classNo);

                          state.push(MaterialPageRoute(builder: (_) {
                            return Topics(
                              classNo: classNo,
                              quesTypeList: quesTypesList,
                            );
                          }));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          // height: 137,
                          height: height * 0.1803,
                          margin:
                              EdgeInsets.only(right: /*21*/ width * 0.05835),
                          // width: 137,
                          width: width * 0.38056,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(236, 240, 241, 1),
                              borderRadius: BorderRadius.circular(/*25*/
                                  height * 0.033),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromRGBO(189, 195, 199, 1),
                                    offset: Offset(0, /*7*/ height * 0.0093))
                              ]),
                          child: Container(
                            // height: 65,
                            height: height * 0.0856,
                            alignment: Alignment.center,
                            // width: 58,
                            width: width * 0.16112,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  // fontSize: 48,
                                  fontSize: height * 0.06316,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.fontFamily),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 11,
                      height: height * 0.01449,
                    ),
                    Container(
                      width: width,
                      // color: Colors.red,
                      margin: EdgeInsets.only(right: /*21*/ width * 0.05835),
                      alignment: Alignment.center,
                      // height: 15,
                      height: height * 0.01975,
                      child: Text('Class ${index + 1}'),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
