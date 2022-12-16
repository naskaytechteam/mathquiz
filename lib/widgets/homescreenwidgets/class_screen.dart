import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/topics.dart';
import '../homescreenwidgets/class_screen_widgets/resume_your_lession.dart';
import '/database/db_helper.dart';
import '/provider/template_factory.dart';
import '/screens/profile_screen.dart';
import 'class_screen_widgets/view_all.dart';
import 'class_screen_widgets/today_topic_container.dart';

class ClassScreen extends StatelessWidget {
  final String name;
  final int userClassNo;
  final int avatarNo;

  const ClassScreen(
      {required this.name,
      required this.userClassNo,
      required this.avatarNo,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: /*40*/ width * 0.11112),
        child: Column(
          children: [
            _buildNameContainer(height, width, context),
            SizedBox(
              height: height * 0.0566,
            ),
            const TodayTopicContainer(),
            SizedBox(
              height: height * 0.0514,
            ),
            _buildTakeATextContainer(height, width, context),
            SizedBox(
              // height: 15,
              height: height * 0.01975,
            ),
            for (int i = userClassNo; i <= DbHelper.totalClass; i = i + 2)
              _buildClassRow(height, width, i, context),
            // SizedBox(
            // height: 30,
            // height: height * 0.0395,
            // ),
            const ResumeYourLesson(),
            SizedBox(
              height: height * 0.03,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClassContainer(
      double height, double width, int classNo, BuildContext context) {
    Color backgroundColor = Theme.of(context).backgroundColor;
    bool isClassSelected = classNo == userClassNo;
    return Align(
      child: SizedBox(
        // height: 170,
        height: height * 0.22369,
        // width: 130,
        width: width * 0.36112,
        child: Column(children: [
          InkWell(
            onTap: () async {
              NavigatorState state = Navigator.of(context);

              List<int> quesTypesList =
                  await TemplateFactory().getQuesTypes(classNo);

              state.push(MaterialPageRoute(builder: (_) {
                return Topics(
                  classNo: userClassNo,
                  quesTypeList: quesTypesList,
                );
              }));
            },
            // onTap: () => _onClassSelected(classNo),
            highlightColor: backgroundColor,
            splashColor: backgroundColor,
            child: Align(
              child: Container(
                alignment: Alignment.center,
                // height: 137,
                height: height * 0.1803,
                // width: 137,
                width: width * 0.38056,
                // width: width * 0.3806,
                decoration: BoxDecoration(
                    color: isClassSelected
                        ? const Color.fromRGBO(241, 196, 15, 1)
                        : const Color.fromRGBO(236, 240, 241, 1),
                    borderRadius: BorderRadius.circular(
                        // 25
                        height * 0.033),
                    boxShadow: [
                      BoxShadow(
                          color: isClassSelected
                              ? const Color.fromRGBO(242, 176, 16, 1)
                              : const Color.fromRGBO(189, 195, 199, 1),
                          offset: Offset(
                              0,
                              // 7
                              height * 0.0093))
                    ]),
                child: SizedBox(
                  // height: 65,
                  height: height * 0.0856,
                  // width: 28,
                  width: width * 0.078,
                  child: Text(
                    classNo.toString(),
                    style: TextStyle(
                        // fontSize: 48,
                        fontSize: height * 0.06316,
                        fontWeight: FontWeight.w900,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily),
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
            alignment: Alignment.center,
            // height: 15,
            height: height * 0.01975,

            child: isClassSelected
                ? Text(
                    'Your Class $classNo',
                  )
                : Text('class $classNo'),
          ),
        ]),
      ),
    );
  }

  Widget _buildClassRow(
      double height, double width, int i, BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // height: 170,
        height: height * 0.22369,
        width: width,
        margin: EdgeInsets.only(
            /*left: 40,right: 40,*/
            bottom: /*20*/ height * 0.02632),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildClassContainer(height, width, i, context),
            if (i + 1 <= DbHelper.totalClass)
              _buildClassContainer(height, width, i + 1, context)
          ],
        ),
      ),
    );
  }

  Widget _buildNameContainer(
      double height, double width, BuildContext context) {
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.278,
            height: height * 0.1,
            alignment: Alignment.bottomLeft,
            child: Text.rich(
              TextSpan(
                  text: 'Good evening\n',
                  style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.headline2?.fontFamily,
                      // fontSize: 14,
                      fontSize: height * 0.0185,
                      color: const Color.fromRGBO(51, 51, 51, 1)),
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        color: const Color.fromRGBO(52, 73, 94, 1),
                        // fontSize: 32,
                        fontSize: height * 0.04215,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ]),
            ),
          ),
          InkWell(
            onTap: () => _goToProfilePage(context),
            child: SvgPicture.asset(
              'assets/images/avatar$avatarNo.svg',
              // height: 59,
              height: height * 0.07764,
              // width: 59,
              width: width * 0.164,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTakeATextContainer(
      double height, double width, BuildContext context) {
    return SizedBox(
      height: height * 0.029,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Take a Test',
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                fontWeight: FontWeight.w900,
                // fontSize: 16
                fontSize: height * 0.0211),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const ViewAll();
              }));
            },
            child: Text(
              'View all',
              style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                  // fontSize: 12,
                  fontSize: height * 0.0158,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  void _goToProfilePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ProfileScreen(
          name: name, classNo: userClassNo, avatarNo: avatarNo);
    }));
  }
}
