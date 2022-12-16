import 'package:flutter/material.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
   int yourClass = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:const Icon(
          Icons.chevron_left,
          size: 40,
          color: Color.fromRGBO(231, 76, 60, 1),
        ),
        toolbarHeight: height * 0.1,
        centerTitle: true,
        title: Text(
          'Take a Test',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
              fontSize: 18,
              color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 36,
          ),
          Container(
            height: 22,
            width: width,
            padding: EdgeInsets.only(left: 40),
            child: Text(
              'Select a Class',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: Theme.of(context).textTheme.headline2?.fontFamily,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 15,
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
                  childAspectRatio: 137 / 170
                // childAspectRatio: width * 0.3806/height * 0.2237,

                // mainAxisSpacing: 0
                  // mainAxisExtent: 6
                  ),
              padding: const EdgeInsets.only(left: 40, right: 19),
              // scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                bool isClassSelected = this.yourClass == index + 1;
                return Column(
                  children: [
                    Align(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            yourClass = index + 1;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 137,
                          margin: const EdgeInsets.only(right: 21),
                          width: 137,
                          decoration: BoxDecoration(
                              color: isClassSelected
                                  ? const Color.fromRGBO(241, 196, 15, 1)
                                  : Color.fromRGBO(236, 240, 241, 1),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                    color: isClassSelected
                                        ? Color.fromRGBO(242, 176, 16, 1)
                                        : Color.fromRGBO(189, 195, 199, 1),
                                    offset: Offset(0, 7))
                              ]),
                          child: Container(
                            height: 65,
                            alignment: Alignment.center,
                            width: 58,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: 48,
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
                      height: 11,
                    ),
                    Container(
                      width: width,
                      // color: Colors.red,
                      margin: EdgeInsets.only(right: 21),
                      alignment: Alignment.center,
                      height: 15,
                      child: Text('Class ${index+1}'),
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
