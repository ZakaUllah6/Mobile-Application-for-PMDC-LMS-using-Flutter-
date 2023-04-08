import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_homescreen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/admin/all_students.dart';
import 'package:pmdc_version_4_flutter/ui/admin/student_registeration_form.dart';
import 'package:pmdc_version_4_flutter/ui/admin/submit_fee.dart';
import 'package:pmdc_version_4_flutter/ui/admin/teacher_registeration_form.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/profile_screen/profile_screen.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_notice_board.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_screen.dart';
import 'package:pmdc_version_4_flutter/widgets/category_container_widget.dart';
import 'package:pmdc_version_4_flutter/widgets/date_sheet_container.dart';
import 'package:pmdc_version_4_flutter/widgets/row_widget.dart';

import 'package:provider/provider.dart';

import '../../../constants/constants.dart';

import '../../auth/login_screen/login_screen.dart';

class Admin_homepage extends StatefulWidget {
  const Admin_homepage({Key? key}) : super(key: key);

  @override
  State<Admin_homepage> createState() => _Admin_homepageState();
}

class _Admin_homepageState extends State<Admin_homepage> {
  ///Images list
  List<IconData> subjectImageList = [
    Icons.add,
    Icons.settings_outlined,
    Icons.add,
    Icons.add,
    Icons.add,
    Icons.add,
    Icons.add,
    Icons.add,
    Icons.add,
  ];
  // List<String> subjectNameList = [
  //   'Chemistry',
  //   'Physics',
  //   'Biology',
  //   'English',
  //   'Maths',
  //   'Urdu',
  //   'Islamyat',
  //   'Pak study',
  //   'Computer \nScience',
  // ];
  List<Color> subjectContainerColor = [
    kAppColor,
    kBlueColor,
    kGreenColor,
    kLightBlueColor,
    kLightCreemColor,
    kLightPinkColor,
    kAppColor,
    kLightBlackColor,
    kLightCreemColor
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminHomeScreenProvider>(
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu_outlined,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Row(
              children: [
                Text(
                  'Welcome ',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  '${adminDetail?.adminName}!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    model.clearData(context);
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
          drawer: const Drawer(
            backgroundColor: Colors.orange,
          ),
          body: ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            progressIndicator: CircularProgressIndicator(
              color: kAppColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Category Row

                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentRegisterationForm()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Add Student"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TeacherRegisterationForm()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Add Teacher"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SubmitFee()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Submit Fee"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      model.getAllStudent(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("All Students"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      model.getAllTeachers(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("All Teachers"),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
