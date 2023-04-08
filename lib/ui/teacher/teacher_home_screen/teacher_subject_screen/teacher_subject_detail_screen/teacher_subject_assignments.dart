import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/student_submitted_assignment.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/upload_screen.dart';

import 'package:provider/provider.dart';

class TeacherSubjectAssignments extends StatelessWidget {
  final index;
  TeacherSubjectAssignments({required this.index, super.key});

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
            'Assignments',
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
                          builder: (context) => UploadVideoLecture(
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
                        'Add Assignment',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                model.assignments!.isEmpty
                    ? Text("No Assignment Yet")
                    : Expanded(
                        child: ListView.builder(
                          itemCount: model.assignments?.length,
                          itemBuilder: (context, index) =>
                              CustomAssignmentScreenContainer(
                            // onTap: () {},
                            containerColor: getRandomColor(),
                            assignment: model.assignments![index],
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

class CustomAssignmentScreenContainer extends StatelessWidget {
  final Color containerColor;

  Assignments assignment;
  final index;
  TeacherHomeScreenProvider model;
  CustomAssignmentScreenContainer({
    required this.assignment,
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
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.withOpacity(.2),
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
                      'S.No : ${assignment.id}',
                    )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      //   height: 25,
                      padding: EdgeInsets.all(5),
                      width: 80,
                      decoration: BoxDecoration(
                        color: kGreenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        ' ${assignment.title}',
                        textAlign: TextAlign.start,
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Topic',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${assignment.topic}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xfff06709),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Download',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date Added: ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' ${DateFormat('dd MMMM yyyy').format(DateTime.parse(assignment.dateAdded))}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await model.getTeacherSubmitedAssignment(index);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentSubmittedAssignments()));
                    },
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xfff06709),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Submission',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UploadVideoLecture(
                                    title: "Assignments",
                                    screenIndex: index,
                                    update: true,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          IconButton(
                            onPressed: () {
                              model.deleteAssignment(assignment.id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Submission Date',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' ${assignment.deadLine}',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
