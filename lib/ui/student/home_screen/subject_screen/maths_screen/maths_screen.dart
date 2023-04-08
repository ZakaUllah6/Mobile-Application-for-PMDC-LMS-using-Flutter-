import 'package:flutter/material.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/subject_screen/student_announcemen.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/subject_screen/student_assignment.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/subject_screen/student_subject_notes.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/subject_screen/student_video_lecture.dart';

import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';
import '../../../../../widgets/subject_details_screen_widget.dart';

class StudentSubjectsDetail extends StatelessWidget {
  Subjects subject;
  StudentSubjectsDetail({required this.subject, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (context, model, ch) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SubjectSetailsScreenWidget(
                  containerColor: kAppColor.withOpacity(.2),
                  onTap: () async {
                    await model.getVideoLecture(int.parse(subject.subjectId));

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentVideoLectureScreen()));
                  },
                  containerIcon: Icons.play_circle_fill_outlined,
                  titleText: 'Videos Lectures',
                  iconColor: kAppColor,
                ),
                SubjectSetailsScreenWidget(
                  containerColor: kBlueColor.withOpacity(.2),
                  onTap: () async {
                    await model.getSubjectNotes(subject.subjectId);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentSubjectNotes()));
                  },
                  containerIcon: Icons.note_outlined,
                  titleText: 'Subject Notes',
                  iconColor: kBlueColor,
                ),
                SubjectSetailsScreenWidget(
                  onTap: () async {
                    await model.getStudentSubmitedAssignment(subject.subjectId);
                    await model.getAssignments(subject.subjectId);
                    model.selectedAssignment = null;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentAssignment()));
                  },
                  containerColor: kPinkColor.withOpacity(.2),
                  containerIcon: Icons.edit_outlined,
                  iconColor: kPinkColor,
                  titleText: 'Assignments',
                ),
                SubjectSetailsScreenWidget(
                  onTap: () {},
                  containerColor: kGreenColor.withOpacity(.2),
                  containerIcon: Icons.library_books_outlined,
                  iconColor: kGreenColor,
                  titleText: 'Subject Diary',
                ),
                SubjectSetailsScreenWidget(
                  onTap: () async {
                    await model.getAnnouncements(subject.subjectId);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentAnnouncement()));
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
                  onTap: () {},
                  containerColor: Colors.red.withOpacity(.2),
                  containerIcon: Icons.file_copy_rounded,
                  iconColor: Colors.red,
                  titleText: 'Model Paper',
                ),
              ],
            ),
          ));
    });
  }
}
