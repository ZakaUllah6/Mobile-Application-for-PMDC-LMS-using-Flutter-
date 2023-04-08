import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/profile_screen/profile_screen.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen.dart';

import 'package:provider/provider.dart';

import '../../../core/enums/view_state.dart';
import '../../student/lectures_screen/lectures_screen.dart';
import '../../student/library_screen/library_screen.dart';
import '../teacher_home_screen/home_screen_provider.dart';
import '../teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_notice_board.dart';
import '../teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_detail_screen.dart';
import '../teacher_home_screen/teacher_subject_screen/teacher_subject_screen.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  static int currentIndex = 0;
  final pages = [
    const TeacherHomeScreen(),
    TeacherSubjectScreen(classId: 0),
    TeacherNoticeBoard(),
    const LibraryScreen(),
    const TeacherProfileScreen()
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherHomeScreenProvider>(
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          body: pages[currentIndex],

          ///TODO: Here we change the background color of Bottom Navigation
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.grey),
            height: 80,
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white54,
                iconSize: 20.0,
                selectedIconTheme: const IconThemeData(
                  size: 26.0,
                ),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                selectedFontSize: 13.0,
                unselectedFontSize: 12,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                unselectedLabelStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: currentIndex,
                onTap: onTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: currentIndex == 0
                        ? Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kAppColor),
                            child: const Icon(Icons.home_outlined),
                          )
                        : const Icon(Icons.home_outlined),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    // backgroundColor: Colors.red,
                    icon: currentIndex == 1
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kAppColor),
                            child: const Icon(Icons.quiz),
                          )
                        : const Icon(Icons.quiz),
                    label: "Subject",
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndex == 2
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kAppColor),
                            child:
                                const Icon(Icons.featured_play_list_outlined),
                          )
                        : const Icon(Icons.featured_play_list_outlined),
                    label: "Notices",
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndex == 3
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kAppColor),
                            child: const Icon(Icons.library_books_outlined),
                          )
                        : const Icon(Icons.library_books_outlined),
                    label: "Library",
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndex == 4
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kAppColor),
                            child: const Icon(Icons.person_outline),
                          )
                        : const Icon(Icons.person_outline),
                    label: "profile",
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
