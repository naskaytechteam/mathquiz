import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/screens/profile_screen.dart';
import 'package:mathquiz/widgets/common_widgets/custom_button.dart';
import '../../utils/user_preferences.dart';
import '/widgets/topics.dart';
import '../homescreenwidgets/class_screen_widgets/resume_your_lession.dart';
import '/database/db_helper.dart';
import '/provider/template_factory.dart';
import 'class_screen_widgets/view_all.dart';
import 'class_screen_widgets/today_topic_container.dart';

class ClassScreen extends StatelessWidget {
  final String name;
  final int userClassNo;
  final int avatarNo;

  ClassScreen({super.key})
      : userClassNo = UserPreferences.getClass()!,
        name = UserPreferences.getName()!,
        avatarNo = UserPreferences.getAvatar()!;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.11112),
      child: Column(
        children: [
          _buildNameContainer(height, width, context),
          _buildGap(height * 0.0566),
          const TodayTopicContainer(),
          _buildGap(height * 0.0514),
          _buildTakeATextContainer(height, width, context),
          _buildGap(height * 0.01975),
          for (int i = userClassNo; i <= DbHelper.totalClass; i = i + 2)
            _buildClassRow(height, width, i, context),
          const ResumeYourLesson(),
          _buildGap(height * 0.03),
        ],
      ),
    );
  }

  Widget _buildClassContainer(
      double height, double width, int classNo, BuildContext context) {
    bool isClassSelected = classNo == userClassNo;
    return Align(
      child: SizedBox(
        // height: 170,
        height: height * 0.22369,
        // width: 130,
        width: width * 0.36112,
        child: Column(children: [
          CustomButton(
            onButtonPressed: () => _onClassSelected(context, classNo),
            height: height * 0.1803,
            width: width * 0.38056,
            backgroundColor: isClassSelected
                ? const Color.fromRGBO(241, 196, 15, 1)
                : const Color.fromRGBO(236, 240, 241, 1),
            shadowColor: isClassSelected
                ? const Color.fromRGBO(242, 176, 16, 1)
                : const Color.fromRGBO(189, 195, 199, 1),
            shadowHeight: height * 0.0093,
            buttonName: classNo.toString(),
            fontSize: height * 0.06316,
            textColor: Colors.black,
          ),
          _buildGap(height * 0.01449),
          SizedBox(
            width: width,
            // alignment: Alignment.center,
            // height: 15,
            height: height * 0.01975,
            child: isClassSelected
                ? Text(
                    'Your Class $classNo',
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'class $classNo',
                    textAlign: TextAlign.center,
                  ),
          ),
        ]),
      ),
    );
  }

  void _showProgressIndicator(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _removeProgressIndicator(NavigatorState state) {
    state.pop();
  }

  //Needs review
  void _onClassSelected(BuildContext context, int classNo) async {
    NavigatorState state = Navigator.of(context);
    _showProgressIndicator(context);
    List<int> quesTypesList = await TemplateFactory().getQuesTypes(classNo);
    _removeProgressIndicator(state);
    state.push(MaterialPageRoute(builder: (_) {
      return Topics(
        classNo: classNo,
        quesTypeList: quesTypesList,
      );
    }));
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
    double height,
    double width,
    BuildContext context,
  ) {
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const ProfileScreen();
              }));
            },
            // onTap: onProfileButtonClick,
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

  Widget _buildGap(double height) {
    return SizedBox(height: height);
  }

  Widget _buildTakeATextContainer(
    double height,
    double width,
    BuildContext context,
  ) {
    return SizedBox(
      height: height * 0.029,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Take a Test',
            style: TextStyle(
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
                  // fontSize: 12,
                  fontSize: height * 0.0158,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
