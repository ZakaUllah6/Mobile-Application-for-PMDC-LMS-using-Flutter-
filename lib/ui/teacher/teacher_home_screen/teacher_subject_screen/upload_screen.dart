import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_screen.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/widgets/custom_textfield.dart';
import 'package:pmdc_version_4_flutter/widgets/signin_login_btn_widget.dart';

import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';

const String staticAssetsPath = "assets/images";

class UploadVideoLecture extends StatefulWidget {
  String title;
  int screenIndex;
  bool update;
  UploadVideoLecture(
      {required this.title,
      required this.screenIndex,
      required this.update,
      Key? key})
      : super(key: key);

  @override
  State<UploadVideoLecture> createState() => _UploadVideoLectureState();
}

class _UploadVideoLectureState extends State<UploadVideoLecture> {
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController chapterNoController = TextEditingController();
  TextEditingController topicNoController = TextEditingController();
  final item = ['item1', 'item2', 'item3'];
  String? value;

  @override
  void initState() {
    final model =
        Provider.of<TeacherHomeScreenProvider>(context, listen: false);
    model.file = null;
    model.imgurl = null;
    if (widget.title == "Assignments") {
      print("update assignment");
      if (widget.update) {
        print("update assignment");
        print('${widget.screenIndex}');
        chapterNameController.text =
            model.assignments![widget.screenIndex].title;
        chapterNoController.text =
            model.assignments![widget.screenIndex].deadLine;
        topicNoController.text = model.assignments![widget.screenIndex].topic;
      }
    } else if (widget.title == "Subject Notes") {
      print("update notes");
      if (widget.update) {
        print("update true");
        chapterNameController.text =
            model.subjectNotes![widget.screenIndex].chapterName;
        chapterNoController.text =
            model.subjectNotes![widget.screenIndex].chapterNo;
        topicNoController.text = model.subjectNotes![widget.screenIndex].topic;
      }
    } else if (widget.title == "Video Lecture") {
      if (widget.update) {
        print("update true");
        chapterNameController.text =
            model.listOfVideoLecture[widget.screenIndex].chapterName;
        chapterNoController.text =
            model.listOfVideoLecture[widget.screenIndex].chapterNo;
        topicNoController.text =
            model.listOfVideoLecture[widget.screenIndex].topic;
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherHomeScreenProvider>(builder: (context, model, ch) {
      if (model.progress > 0 && model.progress < 1) {
        return Center(child: CircularProgressIndicator(value: model.progress));
      }
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
            title: Center(
                child: Text(
              'Upload ${widget.title}',
              style: TextStyle(color: Colors.black),
            ))),
        body: ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CircularProgressIndicator(color: kAppColor),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.title == "Assignments"
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Assignment Title',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                chapterNameController: chapterNameController,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Topic',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  chapterNameController: topicNoController),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Assignment Deadline',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                readOnly: true,
                                controller: chapterNoController,
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2025, 12, 30),
                                  );
                                  if (date != null) {
                                    chapterNoController.text =
                                        DateFormat('dd MMMM yyyy').format(date);
                                    model.assignment.deadLine =
                                        chapterNoController.text;
                                    print(
                                        "asigmnet : ${model.assignment.deadLine}");
                                  }
                                },
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chapter Name',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                chapterNameController: chapterNameController,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Chapter No',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  chapterNameController: chapterNoController),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Topic Name',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  chapterNameController: topicNoController),
                            ],
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    widget.title == "Video Lecture"
                        ? model.isLoading
                            ? CircularProgressIndicator(
                                color: kAppColor,
                              )
                            : model.imgurl == null
                                ? customBottomCard(
                                    //  isSmall: isSmall,
                                    text: 'Upload Document',
                                    asset: '$staticAssetsPath/inbox.png',
                                    onTap: () async {
                                      final docPath =
                                          await model.videotakenGallery();
                                    },
                                  )
                                : customBottomCard(
                                    //  isSmall: isSmall,
                                    text: 'Change Document',
                                    asset: '$staticAssetsPath/inbox.png',
                                    onTap: () async {
                                      final docPath =
                                          await model.videotakenGallery();
                                    },
                                  )
                        : model.file == null
                            ? customBottomCard(
                                //  isSmall: isSmall,
                                text: 'Upload Document',
                                asset: '$staticAssetsPath/inbox.png',
                                onTap: () async {
                                  final docPath =
                                      await model.openFilePicker(context);
                                  model.documentFile = docPath;
                                },
                              )
                            : customBottomCard(
                                text: 'Change Document',
                                asset: '$staticAssetsPath/inbox.png',
                                onTap: () async {
                                  var response = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        "Do you want to see existing document instead?",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: kAppColor),
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop(true);
                                          },
                                          child: Text('View Document',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              )),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: kAppColor),
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop(false);
                                          },
                                          child: Text(
                                            'Change Document',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (response) {
                                    model.viewFile(model.file!);
                                  } else {
                                    final docPath =
                                        await model.openFilePicker(context);
                                    model.documentFile = docPath;
                                  }
                                },
                              ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 20, top: 5, bottom: 5),
                      child: signIn_login_Btn_widget(
                          onTap: () {
                            if (model.formKey.currentState!.validate()) {
                              if (widget.title == "Assignments") {
                                model.assignment.title =
                                    chapterNameController.text;

                                model.assignment.topic = topicNoController.text;
                                print(
                                    "pressed assignment ${model.assignment.deadLine}");
                                if (widget.update) {
                                  model.UpdateAssignments(
                                      widget.screenIndex, context);
                                  widget.update = false;
                                } else {
                                  print("add assignment");
                                  model.addAssignment(
                                      widget.screenIndex, context);
                                }
                              } else if (widget.title == "Subject Notes") {
                                model.subjectNote.chapterName =
                                    chapterNameController.text;
                                model.subjectNote.chapterNo =
                                    chapterNoController.text;
                                model.subjectNote.topic =
                                    topicNoController.text;
                                print("pressed");
                                if (widget.update) {
                                  model.UpdateSubjectNotes(
                                      widget.screenIndex, context);
                                  widget.update = false;
                                } else {
                                  model.addSubjectNotes(
                                      widget.screenIndex, context);
                                }
                              } else if (widget.title == "Video Lecture") {
                                if (model.imgurl == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Video is compulsory")));
                                  return;
                                }
                                model.videoLecture.chapterName =
                                    chapterNameController.text;
                                model.videoLecture.chapterNo =
                                    chapterNoController.text;
                                model.videoLecture.topic =
                                    topicNoController.text;
                                if (model.isLoading) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Wait for video to upload")));
                                  return;
                                }
                                if (widget.update) {
                                  model.UpdateVideoLecture(
                                      widget.screenIndex, context);
                                  widget.update = false;
                                } else {
                                  model.addVideoLecture(
                                      widget.screenIndex, context);
                                }
                              }
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UploadVideoLecture()));
                          },
                          containerText: 'Upload'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

customBottomCard({asset, text, onTap}) {
  return Material(
    // clipBehavior,
    color: kAppColor,
    child: InkWell(
      splashColor: kAppColor.withOpacity(0.5),
      onTap: onTap,
      child: Container(
        height: 42,
        width: 100,
        // height: 42.h,
        // width: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            ImageContainer(
              height: 18,
              width: 18,
              assets: asset,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 7,
            ),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              width: 7,
            ),
          ],
        ),
      ),
    ),
  );
}

class ImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final String assets;
  final Color? color;

  /// This is for  local Asset
  final String? url;

  /// This one is for Network Image,
  final BoxFit fit;
//  final

  ImageContainer(
      {this.height,
      this.width,
      this.assets = "assets/static_assets/user_icon.png",
      this.radius = 0,
      this.url,
      this.fit = BoxFit.cover,
      this.color = Colors.transparent});
  @override
  Widget build(BuildContext context) {
    return url == null
        ? Container(
            height: this.height,
            width: this.width,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                  image: AssetImage(this.assets),
                  fit: fit,
                )),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: FadeInImage(
              width: this.width,
              height: this.height,
              image: NetworkImage(url!),
              placeholder: AssetImage(this.assets),
              fit: this.fit,
            ),
          );
  }
}
