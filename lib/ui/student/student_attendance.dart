import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_home_page.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_homescreen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/edit_student.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';

import 'package:provider/provider.dart';

class StudentAttendance extends StatelessWidget {
  StudentAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (context, model, index) {
      print("object<<<<<<<<<<<<<<<<<<<<<<<");
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              'Student Attendance',
              style: TextStyle(color: Colors.black),
            )),
        body: ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CircularProgressIndicator(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                model.listOfAttendance.isEmpty
                    ? Text("No Attendance Yet")
                    : Expanded(
                        child: ListView.builder(
                          itemCount: model.listOfAttendance.length,
                          itemBuilder: (context, index) =>
                              CustomAnnouncementScreenContainer(
                            // onTap: () {},
                            containerColor: getRandomColor(),
                            attendance: model.listOfAttendance[index],
                            index: index,
                            model: model,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CustomAnnouncementScreenContainer extends StatelessWidget {
  final Color containerColor;

  Attendance attendance;
  final index;
  HomeScreenProvider model;
  CustomAnnouncementScreenContainer({
    required this.attendance,
    required this.containerColor,
    required this.index,
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                      color: kAppColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      '${attendance.studentName}',
                    )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      color: kGreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      ' ${attendance.date}',
                    )),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: attendance.attendancestatus == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
