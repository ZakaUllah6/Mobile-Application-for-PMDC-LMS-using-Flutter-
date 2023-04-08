import 'package:flutter/material.dart';
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

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
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
    return Consumer<TeacherHomeScreenProvider>(
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
                  '${teacherDetails?.teacherName}!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TeacherProfileScreen()));
                  },
                  child: Image.asset('assets/images/title_img.png')),
            ],
          ),
          drawer: const Drawer(
            backgroundColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ///Category Row

                  const SizedBox(
                    height: 10,
                  ),

                  ///Category Container
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          model.filterSubjects(1);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeacherSubjectScreen(
                                        classId: 1,
                                      )));
                        },
                        child: CategoryContainerWidget(
                          containerText: '1st year',
                          containerColor: kAppColor,
                          containerImage: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/classes_icon.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          model.filterSubjects(2);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeacherSubjectScreen(
                                        classId: 2,
                                      )));
                        },
                        child: CategoryContainerWidget(
                          containerText: '2nd year',
                          containerColor: kGreenColor,
                          containerImage: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/tests_img.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///Notice Board Row
                  RowWidget(
                    tileName: 'Notice Board',
                    seeAllText: 'See All',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TeacherNoticeBoard()));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Notice Board Container
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TeacherNoticeBoard()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getRandomColor(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    'S.No : ${model.noticeBoard[1].id}',
                                  )),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  //   height: 25,
                                  //  width: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kGreenColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Subject: ${model.noticeBoard[1].subject}',
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              '${model.noticeBoard[1].notice}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Published Date:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  '${model.noticeBoard[1].date}',
                                  style: TextStyle(fontSize: 10.5),
                                ),
                                Text(
                                  'Published Date:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  '27-Jan-2023',
                                  style: TextStyle(fontSize: 10.5),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///My Subjects Row
                  RowWidget(
                    tileName: "Assign Subjects",
                    seeAllText: 'See All',
                    onTap: () {
                      model.filterSubjects(0);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeacherSubjectScreen(
                                    classId: 0,
                                  )));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      // border: Border.all(width: 1, color: Colors.grey)
                    ),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(5),
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: model.teacherSubjects.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              model.filterSubjects(
                                  model.teacherSubjects[index].classId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherSubjectScreen(
                                            classId: model
                                                .teacherSubjects[index].classId,
                                          )));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 75,
                                      width: 75,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        //  borderRadius: BorderRadius.circular(50),
                                        color: subjectContainerColor[index],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${model.teacherSubjects[index].section}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${model.teacherSubjects[index].classId == 1 ? "1st" : "2nd"}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                      // Icon(
                                      //   subjectImageList[index],
                                      //   size: 50,
                                      //   color: Colors.white,
                                      // ),
                                      ),
                                  const SizedBox(height: 10),
                                  Text(
                                    // model.teacherSubjects[index].subjectName ==
                                    //         "Introduction to computing"
                                    //     ? "ITC \n${programs[model.teacherSubjects[index].programId - 1] == "Computer Sciences" ? "Com.Sci" : programs[model.teacherSubjects[index].programId - 1] == "Pre-Engineering" ? "Engineering" : programs[model.teacherSubjects[index].programId - 1]}"
                                    //    :

                                    programs[model.teacherSubjects[index]
                                                    .programId -
                                                1] ==
                                            "Computer Sciences"
                                        ? "Com.Sci"
                                        : programs[model.teacherSubjects[index]
                                                        .programId -
                                                    1] ==
                                                "Pre-Engineering"
                                            ? "Engineering"
                                            : programs[model
                                                    .teacherSubjects[index]
                                                    .programId -
                                                1],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Date Sheet Row and Container

                  ///Time Table Row and Container
                  RowWidget(
                      tileName: "Time Table",
                      seeAllText: "See All",
                      onTap: () {}),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kLightBlueColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'S#',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Class',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Program',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Section',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Flexible(
                                  child: DateSheetContainerWidgets(
                                text: '1',
                              )),
                              SizedBox(width: 5),
                              Flexible(
                                  child: DateSheetContainerWidgets(
                                text: 'XII',
                              )),
                              SizedBox(width: 5),
                              Flexible(
                                  child: DateSheetContainerWidgets(
                                text: 'Computer Science',
                              )),
                              SizedBox(width: 5),
                              Flexible(
                                  child: DateSheetContainerWidgets(
                                text: 'Theory',
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xfff06709),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Text(
                                  'Download',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Attendance Report Row And Container
                ],
              ),
            ),
          )),
    );
  }
}
