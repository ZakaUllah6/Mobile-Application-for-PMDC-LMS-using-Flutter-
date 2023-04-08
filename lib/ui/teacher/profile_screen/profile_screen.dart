import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_screen.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/widgets/profile_screen_row_widget.dart';

import 'package:provider/provider.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherHomeScreenProvider>(builder: (context, model, ch) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: kLightBlackColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Center(
                child: Text(
              'My Profile ',
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              InkWell(
                  onTap: () {
                    model.logOut(context);
                  },
                  child: Icon(Icons.logout))
            ],
          ),
          drawer: const Drawer(
            backgroundColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: kLightBlackColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset('assets/images/profile_img.png'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${teacherDetails?.teacherName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Divider(
                    thickness: 1,
                    color: kLightBlackColor,
                  ),
                ),
                ProfileScreenRowWidget(
                  text1: 'ID',
                  value1: '${teacherDetails?.teacherid}',
                  text2: 'Name',
                  value2: '${teacherDetails?.teacherName}',
                ),
                ProfileScreenRowWidget(
                  text1: 'DOB',
                  value1: '${teacherDetails?.dateOfBirth}',
                  text2: 'Status',
                  value2: '${teacherDetails?.status}',
                ),
                ProfileScreenRowWidget(
                  text1: 'Qualification',
                  value1: '${teacherDetails?.qualification}',
                  text2: 'Session',
                  value2: '${teacherDetails?.age}',
                ),
                ProfileScreenRowWidget(
                  text1: 'Transport',
                  value1: teacherDetails!.transport ? 'Yes' : 'No',
                  text2: 'Bus ID',
                  value2: '${teacherDetails?.busId}',
                ),
              ],
            ),
          ));
    });
  }
}
