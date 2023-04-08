import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/announcement_upload_screen.dart';

import 'package:provider/provider.dart';

class TeacherSubjectDiary extends StatelessWidget {
  final index;
  TeacherSubjectDiary({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
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
          title: const Center(
              child: Text(
            'Subject Diary',
            style: TextStyle(color: Colors.black),
          ))),
      body: Consumer<TeacherHomeScreenProvider>(builder: (context, model, ch) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CircularProgressIndicator(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AnnouncementScreen(
                            title: "Assignments",
                            screenIndex: index,
                            update: false,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Add Diary',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                model.subjectDiaries.isEmpty
                    ? Text("No Notices Yet")
                    : Expanded(
                        child: ListView.builder(
                          itemCount: model.subjectDiaries.length,
                          itemBuilder: (context, index) =>
                              CustomAnnouncementScreenContainer(
                            // onTap: () {},
                            containerColor: getRandomColor(),
                            subjectDiary: model.subjectDiaries[index],
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
        );
      }),
    );
  }
}

class CustomAnnouncementScreenContainer extends StatelessWidget {
  final Color containerColor;

  SubjectDiary subjectDiary;
  final index;
  TeacherHomeScreenProvider model;
  CustomAnnouncementScreenContainer({
    required this.subjectDiary,
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
        height: 220,
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
                      'S.No : ${subjectDiary.id}',
                    )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    //  height: 25,
                    decoration: BoxDecoration(
                      color: kGreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      ' ${subjectDiary.chapterName}',
                    )),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 0,
                        ),
                        IconButton(
                          onPressed: () {
                            model.deleteAnnouncement(announcement.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Topic',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        ' ${subjectDiary.}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      "${DateFormat('dd MMMM yyyy').format(DateTime.parse(announcement.publishDate))}")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
