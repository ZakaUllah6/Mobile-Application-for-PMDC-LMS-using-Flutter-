import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_screen/home_screen_provider.dart';

import 'package:provider/provider.dart';

class StudentNoticeBoard extends StatelessWidget {
  StudentNoticeBoard({super.key});

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
            'NoticeBoard',
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
                model.noticeBoard.isEmpty
                    ? Text("No Notices Yet")
                    : Expanded(
                        child: ListView.builder(
                          itemCount: model.noticeBoard.length,
                          itemBuilder: (context, index) => NoticeBoardStudent(
                            // onTap: () {},

                            noticeBoard: model.noticeBoard[index],
                            containerColor: getRandomColor(),
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

  Announcement announcement;
  final index;
  HomeScreenProvider model;
  CustomAnnouncementScreenContainer({
    required this.announcement,
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
                      'S.No : ${announcement.id}',
                    )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      color: kGreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      ' ${announcement.title}',
                    )),
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        ' ${announcement.description}',
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
