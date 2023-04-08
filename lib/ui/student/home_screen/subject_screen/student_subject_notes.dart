import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/core/services/file_download.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen_provider.dart';

import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';

class StudentSubjectNotes extends StatelessWidget {
  StudentSubjectNotes({Key? key}) : super(key: key);

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
            'Subject Notes',
            style: TextStyle(color: Colors.black),
          ))),
      body: Consumer<HomeScreenProvider>(builder: (context, model, ch) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CircularProgressIndicator(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                model.subjectNotes.isEmpty
                    ? Center(
                        child: Text(
                          "No Notes Yet",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: model.subjectNotes.length,
                          itemBuilder: (context, index) =>
                              CustomSubjectNotesContainer(
                            onTap: () {},
                            containerColor: getRandomColor(),
                            subjectNotes: model.subjectNotes[index],
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
  SubjectNotes subjectNotes;
  final index;
  HomeScreenProvider model;
  CustomSubjectNotesContainer({
    Key? key,
    required this.subjectNotes,
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
                        '${subjectNotes.id}',
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
                        '${subjectNotes.chapterNo}',
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${subjectNotes.chapterName} ',
                        style: TextStyle(
                          //  color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          print("pressedddddd");
                          downloadFile(subjectNotes.file);
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${subjectNotes.topic}',
                style: TextStyle(
                  //  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.calendar_month),
                    Text("Date: "),
                    Flexible(
                      child: Text(
                        "${DateFormat('dd MMMM yyyy').format(DateTime.parse(subjectNotes.dateAdded))}",
                        overflow: TextOverflow.ellipsis,
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
