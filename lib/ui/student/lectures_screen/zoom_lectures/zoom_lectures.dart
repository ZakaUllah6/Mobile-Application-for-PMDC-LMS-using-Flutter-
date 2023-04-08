import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/widgets/zoom_lectures_container_widget.dart';

class ZoomLecturesScreen extends StatelessWidget {
  const ZoomLecturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: kAppColor,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: const Center(
            child: Text(
          'Zoom Lectures',
          style: TextStyle(color: Colors.black),
        )),
        actions: [
          Image.asset('assets/images/title_img.png'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ZoomLecturesContainerWidget(
              subjectName: 'Process,Multi Programming & \nMulti threading',
              containerColor: kLightBlueColor,
            ),
            ZoomLecturesContainerWidget(
              subjectName: 'Functions of Operating System\n',
              containerColor: kAppColor,
            ),
            ZoomLecturesContainerWidget(
              subjectName: 'Process,Multi Programming & \nMulti threading',
              containerColor: kPinkColor,
            ),
            ZoomLecturesContainerWidget(
              subjectName: 'Functions of Operating System',
              containerColor: kGreenColor,
            ),
            ZoomLecturesContainerWidget(
              subjectName: 'Process,Multi Programming & \nMulti threading',
              containerColor: kLightBlueColor,
            ),
          ],
        ),
      ),
    );
  }
}
//comment