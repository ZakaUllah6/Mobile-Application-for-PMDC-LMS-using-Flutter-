import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_screen.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/widgets/profile_screen_row_widget.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, model, ch) => Scaffold(
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
                    model.clearData(context);
                  },
                  child: Icon(Icons.logout)),
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
                        '${studentDetails?.firstName} ${studentDetails?.lastName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Father Name:',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${studentDetails?.fatherName}',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
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
                  text1: 'Form No.',
                  value1: '01-21-0849',
                  text2: 'Student ID',
                  value2: '${studentDetails?.studentid}',
                ),
                ProfileScreenRowWidget(
                  text1: 'DOB',
                  value1: '${studentDetails?.dateOfBirth}',
                  text2: 'Admission Date',
                  value2: '${studentDetails?.admissionDate}',
                ),
                ProfileScreenRowWidget(
                  text1: 'Program',
                  value1: '${studentDetails?.programId}',
                  text2: 'Session',
                  value2: '2021-2023',
                ),
                ProfileScreenRowWidget(
                  text1: 'Class',
                  value1: '${studentDetails?.classId}',
                  text2: 'Section',
                  value2: '${studentDetails?.section}',
                ),
                ProfileScreenRowWidget(
                  text1: 'Status',
                  value1: studentDetails!.statue ? 'Active' : 'Blocked',
                  text2: 'Scholership',
                  value2: studentDetails!.scholarship ? 'Yes' : 'No',
                ),
                ProfileScreenRowWidget(
                  text1: 'Transport',
                  value1: studentDetails!.transport ? 'Yes' : 'No',
                  text2: 'Bus ID',
                  value2: '${studentDetails?.busId}',
                ),
              ],
            ),
          )),
    );
  }
}
