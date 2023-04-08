import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_detail_screen.dart';

import 'package:provider/provider.dart';

class TeacherSubjectScreen extends StatefulWidget {
  int classId;

  TeacherSubjectScreen({required this.classId, Key? key}) : super(key: key);

  @override
  State<TeacherSubjectScreen> createState() => _TeacherSubjectScreenState();
}

class _TeacherSubjectScreenState extends State<TeacherSubjectScreen> {
  @override
  void initState() {
    Provider.of<TeacherHomeScreenProvider>(context, listen: false)
        .filterSubjects(widget.classId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherHomeScreenProvider>(builder: (context, model, ch) {
      return DefaultTabController(
        length: model.filterSubject.length,
        child: Scaffold(
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
              title: const Center(
                  child: Text(
                'Subjects',
                style: TextStyle(color: Colors.black),
              ))),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TabBar(
                    isScrollable: true,
                    labelColor: kAppColor,
                    indicatorColor: kAppColor,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.w600),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 5,
                    indicatorPadding: EdgeInsets.only(top: 3),
                    tabs: List.generate(
                      model.filterSubject.length,
                      (index) => Center(
                        child: Tab(
                            text:
                                "${programs[model.filterSubject[index].programId - 1] == "Computer Sciences" ? "Course: C.S" : programs[model.filterSubject[index].programId - 1] == "Pre-Engineering" ? "Course: Engineering" : "Course: ${programs[model.filterSubject[index].programId - 1]}"} (${model.filterSubject[index].section})\n${model.filterSubject[index].subjectName}"),
                      ),
                    )

                    // [

                    //   Tab(text: 'Chemistry'),
                    //   Tab(text: 'Biology'),
                    //   Tab(text: 'Physics'),
                    //   Tab(text: 'Computer Science'),
                    //   Tab(text: 'English'),
                    //   Tab(text: 'Urdu'),
                    //   Tab(text: 'Islamyat'),
                    // ]
                    ),
              ),
              Expanded(
                child: TabBarView(
                  children: List.generate(
                    model.filterSubject.length,
                    (index) => TeacherSubjectDetailScreen(screenIndex: index),
                  ),
                  //   [
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   MathsScreen(),
                  //   // ChemistryScreen(),
                  //   // BiologyScreen(),
                  //   // PhysicsScreen(),
                  //   // ComputerScienceScreen(),
                  //   // EnglishScreen(),
                  //   // UrduScreen(),
                  //   // IslamyatScreen(),
                  // ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
