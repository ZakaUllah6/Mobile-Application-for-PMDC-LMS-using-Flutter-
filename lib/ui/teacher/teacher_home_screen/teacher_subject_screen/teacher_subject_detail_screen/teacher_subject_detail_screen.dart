import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_announcement.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_assignments.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_notes.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_student.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_video_lecture.dart';
import 'package:pmdc_version_4_flutter/widgets/subject_details_screen_widget.dart';

import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';

class TeacherSubjectDetailScreen extends StatelessWidget {
  int screenIndex;
  TeacherSubjectDetailScreen({required this.screenIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherHomeScreenProvider>(builder: (context, model, ch) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SubjectSetailsScreenWidget(
                  containerColor: kAppColor.withOpacity(.2),
                  onTap: () async {
                    await model
                        .getVideoLecture(model.filterSubject[screenIndex]);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TeacherVideoLectureScreen(index: screenIndex)));
                  },
                  containerIcon: Icons.play_circle_fill_outlined,
                  titleText: 'Videos Lectures',
                  iconColor: kAppColor,
                ),
                SubjectSetailsScreenWidget(
                  containerColor: kBlueColor.withOpacity(.2),
                  onTap: () async {
                    await model
                        .getSubjectNotes(model.filterSubject[screenIndex]);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TeacherSubjectNotesScreen(index: screenIndex)));
                  },
                  containerIcon: Icons.note_outlined,
                  titleText: 'Subject Notes',
                  iconColor: kBlueColor,
                ),
                SubjectSetailsScreenWidget(
                  onTap: () async {
                    await model
                        .getAssignments(model.filterSubject[screenIndex]);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TeacherSubjectAssignments(index: screenIndex)));
                  },
                  containerColor: kPinkColor.withOpacity(.2),
                  containerIcon: Icons.edit_outlined,
                  iconColor: kPinkColor,
                  titleText: 'Assignments',
                ),
                // SubjectSetailsScreenWidget(
                //   onTap: () {},
                //   containerColor: kGreenColor.withOpacity(.2),
                //   containerIcon: Icons.library_books_outlined,
                //   iconColor: kGreenColor,
                //   titleText: 'Subject Diary',
                // ),
                SubjectSetailsScreenWidget(
                  onTap: () async {
                    await model
                        .getAnnouncements(model.filterSubject[screenIndex]);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TeacherSubjectAnnouncement(index: screenIndex)));
                  },
                  containerColor: Colors.blue.withOpacity(.2),
                  containerIcon: Icons.question_mark_outlined,
                  iconColor: Colors.blue,
                  titleText: 'Announcements',
                ),
                SubjectSetailsScreenWidget(
                  onTap: () {},
                  containerColor: Colors.purple.withOpacity(.2),
                  containerIcon: Icons.sticky_note_2,
                  iconColor: Colors.purple,
                  titleText: 'Syllabus',
                ),
                SubjectSetailsScreenWidget(
                  onTap: () async {
                    await model.listOfStudent(model.filterSubject[screenIndex]);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TeacherSubjectStudent()));
                  },
                  containerColor: Colors.red.withOpacity(.2),
                  containerIcon: Icons.file_copy_rounded,
                  iconColor: Colors.red,
                  titleText: 'Students',
                ),
              ],
            ),
          ));
    });
  }
}
