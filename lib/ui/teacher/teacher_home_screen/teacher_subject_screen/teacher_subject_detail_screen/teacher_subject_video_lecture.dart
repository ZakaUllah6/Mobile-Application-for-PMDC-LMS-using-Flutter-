import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/core/services/file_download.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/upload_screen.dart';

import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';

class TeacherVideoLectureScreen extends StatefulWidget {
  int index;
  TeacherVideoLectureScreen({required this.index, Key? key}) : super(key: key);

  @override
  State<TeacherVideoLectureScreen> createState() =>
      _TeacherVideoLectureScreenState();
}

class _TeacherVideoLectureScreenState extends State<TeacherVideoLectureScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  init() async {
    final model =
        Provider.of<TeacherHomeScreenProvider>(context, listen: false);
    await model.getVideoLecture(model.filterSubject[widget.index]);
    setState(() {});
  }

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
            'Video Lecture',
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
                            title: "Video Lecture",
                            screenIndex: widget.index,
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
                        'Add Lecture',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                model.listOfVideoLecture.isEmpty
                    ? Text(
                        "No Lectures Yet",
                        textAlign: TextAlign.center,
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: model.listOfVideoLecture.length,
                          itemBuilder: (context, index) =>
                              CustomSubjectNotesContainer(
                            onTap: () {},
                            containerColor: getRandomColor(),
                            videoLecture: model.listOfVideoLecture[index],
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

class CustomSubjectNotesContainer extends StatelessWidget {
  final Color containerColor;
  final VoidCallback onTap;
  VideoLectures videoLecture;
  final index;
  TeacherHomeScreenProvider model;
  CustomSubjectNotesContainer({
    Key? key,
    required this.videoLecture,
    required this.containerColor,
    required this.onTap,
    required this.index,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: EdgeInsets.all(5),
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Chapter Name: ',
                        style: TextStyle(
                          //      color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${videoLecture.chapterNo}',
                        style: TextStyle(
                            //  color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Chapter/unit No:',
                        style: TextStyle(
                          //   color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${videoLecture.id}',
                        style: TextStyle(
                            //   color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Topic',
                style: TextStyle(
                    //  color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${videoLecture.chapterName} ',
                        style: TextStyle(
                          //  color: Colors.white,
                          fontSize: 15,
                        ),
                        //  textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await downloadFile(videoLecture.file, video: true);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff06709),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'download',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Description',
                style: TextStyle(
                    //    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${videoLecture.topic}',
                style: TextStyle(
                  //  color: Colors.white,
                  fontSize: 15,
                ),
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
                                    title: "Video Lecture",
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
                              model.deleteVideoLecture(videoLecture.id, index);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text("Date: "),
                          Flexible(
                            child: Text(
                              "${DateFormat('dd MMMM yyyy').format(DateTime.parse(videoLecture.dateAdded))}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )
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
