import 'package:flutter/material.dart';
import '../../../provider/template_factory.dart';
import '../../common_widgets/custom_gridview.dart';
import '../../topics.dart';
import '/widgets/common_widgets/custom_app_bar.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Take a Test',
        height: height * 0.1,
      ),
      body: Column(
        children: [
          _buildGap(height * 0.04737),
          Padding(
            padding: EdgeInsets.only(left: /*40*/ width * 0.1112),
            child: SizedBox(
              // height: 22,
              height: height * 0.029,
              width: width,
              child: Text(
                'Select a Class',
                style: TextStyle(
                    // fontSize: 16,
                    fontSize: height * 0.0211,
                    fontFamily:
                        Theme.of(context).textTheme.headline2?.fontFamily,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          _buildGap(height * 0.01975),
          CustomGridView(
            totalHeight: height * 0.75,
            mainAxisExtent: height * 0.24606,
            isTopicScreen: false,
            containerHeight: height * 0.1803,
            containerWidth: width * 0.38056,
            fontSize: height * 0.06316,
            onButtonClick: _onClassSelected,
          )
          // gridView(height, width,context)
        ],
      ),
    );
  }

  void _onClassSelected(BuildContext context, int index) async {
    NavigatorState state = Navigator.of(context);
    int classNo = index + 1;

    List<int> quesTypesList = await TemplateFactory().getQuesTypes(classNo);
    state.push(MaterialPageRoute(builder: (_) {
      return Topics(
        classNo: classNo,
        quesTypeList: quesTypesList,
      );
    }));
  }

  Widget _buildGap(double height) {
    return SizedBox(height: height);
  }
}
