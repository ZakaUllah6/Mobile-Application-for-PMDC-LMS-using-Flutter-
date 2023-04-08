import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/subject_screen/subject_screen.dart';
import 'package:pmdc_version_4_flutter/ui/student/notice_board_student.dart';
import 'package:pmdc_version_4_flutter/ui/student/profile_screen/profile_screen.dart';
import 'package:pmdc_version_4_flutter/ui/student/student_attendance.dart';
import 'package:pmdc_version_4_flutter/widgets/date_sheet_container.dart';

import 'package:provider/provider.dart';

import '../../../widgets/category_container_widget.dart';
import '../../../widgets/row_widget.dart';
import '../../auth/login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Consumer<HomeScreenProvider>(
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
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
                    '${studentDetails?.firstName}!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
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

                    ///Category Container
                    Row(
                      children: [
                        CategoryContainerWidget(
                          containerText: 'Fee',
                          containerColor: kAppColor,
                          containerImage: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/classes_icon.png',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SubjectScreen()));
                          },
                          child: CategoryContainerWidget(
                            containerText: 'Subjects',
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
                            builder: (context) => StudentNoticeBoard()));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Notice Board Container
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentNoticeBoard()));
                      },
                      child: NoticeBoardStudent(
                        noticeBoard: model.noticeBoard[0],
                        containerColor: getRandomColor(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///My Subjects Row
                    RowWidget(
                      tileName: "My Subjects",
                      seeAllText: 'See All',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SubjectScreen()));
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
                          itemCount: model.studentSubjects.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: subjectContainerColor[index],
                                    ),
                                    child: Icon(
                                      Icons.subject_sharp,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    model.studentSubjects[index].subjectName,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Date Sheet Row and Container
                    RowWidget(
                        tileName: 'Date Sheet',
                        seeAllText: 'Sell All',
                        onTap: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kLightBlueColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: '1',
                                )),
                                SizedBox(width: 5),
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: studentDetails?.classId == 1
                                      ? '${studentDetails?.classId}st'
                                      : '${studentDetails?.classId}nd',
                                )),
                                SizedBox(width: 5),
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: studentDetails?.programId == 1
                                      ? 'Computer Sciences'
                                      : studentDetails?.programId == 2
                                          ? 'Pre-Engineering'
                                          : 'Medical',
                                )),
                                SizedBox(width: 5),
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: 'Theory',
                                )),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
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

                    ///Student Fee Record Row and Container
                    RowWidget(
                        tileName: 'Student Fee Record',
                        seeAllText: ' ',
                        onTap: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      //    height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kPinkColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                headingRowHeight: 26,
                                dataRowHeight: 26,
                                border: TableBorder.all(
                                    color: Colors.white, width: 1),
                                decoration: BoxDecoration(
                                  color: kPinkColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                columns: [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Paid')),
                                  DataColumn(label: Text('Date-Paid')),
                                ],
                                rows: List.generate(
                                  model.feeRecords.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                          Text('${studentDetails?.firstName}')),
                                      DataCell(Text(
                                          '${model.feeRecords[index].paid}')),
                                      DataCell(Text(
                                          '${model.feeRecords[index].instalmentDate}')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Total Fee: ${model.feeRecords[0].totalFee}"),
                                Text("Paid : ${model.paid}"),
                                Text("UnPaid : ${model.unPaid}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Time Table Row and Container
                    RowWidget(
                        tileName: "Time Table", seeAllText: " ", onTap: () {}),
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
                              children: [
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: '1',
                                )),
                                SizedBox(width: 5),
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: studentDetails?.classId == 1
                                      ? '${studentDetails?.classId}st'
                                      : '${studentDetails?.classId}nd',
                                )),
                                SizedBox(width: 5),
                                Flexible(
                                    child: DateSheetContainerWidgets(
                                  text: studentDetails?.programId == 1
                                      ? 'Computer Sciences'
                                      : studentDetails?.programId == 2
                                          ? 'Pre-Engineering'
                                          : 'Medical',
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
                    RowWidget(
                        tileName: "Attendance Report",
                        seeAllText: 'See All',
                        onTap: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        model.getAttendance();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentAttendance()));
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kGreenColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Student Absent/Leave(s) Record',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Flexible(
                                      child: DateSheetContainerWidgets(
                                    text: 'S.No.',
                                  )),
                                  SizedBox(width: 5),
                                  Flexible(
                                      child: DateSheetContainerWidgets(
                                    text: 'Date',
                                  )),
                                  SizedBox(width: 5),
                                  Flexible(
                                      child: DateSheetContainerWidgets(
                                    text: 'Computer Science',
                                  )),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 100,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Absent/Leave(s) Record Not Found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class NoticeBoardStudent extends StatelessWidget {
  final Color containerColor;
  NoticeBoard noticeBoard;
  NoticeBoardStudent({
    required this.containerColor,
    required this.noticeBoard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor,
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
                    'S.No : ${noticeBoard.id}',
                  )),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  //  height: 25,
                  //  width: 80,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kGreenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'Subject: ${noticeBoard.subject}',
                  )),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              '${noticeBoard.notice}',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Published Date:',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '${noticeBoard.date}',
                  style: TextStyle(fontSize: 10.5),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
