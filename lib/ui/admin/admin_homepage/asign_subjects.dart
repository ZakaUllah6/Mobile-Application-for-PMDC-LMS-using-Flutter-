import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_home_page.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_homescreen_provider.dart';

import 'package:pmdc_version_4_flutter/widgets/alert_dialog_box.dart';
import 'package:pmdc_version_4_flutter/widgets/custom_textfield.dart';
import 'package:pmdc_version_4_flutter/widgets/signin_login_btn_widget.dart';

import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';

const String staticAssetsPath = "assets/images";

class AssignASubject extends StatefulWidget {
  AssignASubject({Key? key}) : super(key: key);

  @override
  State<AssignASubject> createState() => _AssignASubjectState();
}

class _AssignASubjectState extends State<AssignASubject> {
  TextEditingController title = TextEditingController();
  final assignClassNo = GlobalKey<FormFieldState>();
  final assignSectionMen = GlobalKey<FormFieldState>();
  final assignProgremMen = GlobalKey<FormFieldState>();
  final assignSubject = GlobalKey<FormFieldState>();
  GlobalKey<FormState> formKey = GlobalKey();

  DropdownMenuItem<String> buildSection(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ));

  DropdownMenuItem<String> buildClassNo(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ));
  DropdownMenuItem<String> buildProgram(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ));
  DropdownMenuItem<String> buildSubject(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ));
  String? section;
  String? program;
  String? classNoo;
  String? subjectName;

  @override
  void initState() {
    final model = Provider.of<AdminHomeScreenProvider>(context, listen: false);
    model.imageee = null;
    model.image = null;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminHomeScreenProvider>(builder: (context, model, ch) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: CircularProgressIndicator(
          color: kAppColor,
        ),
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
                'Assign Subject Form',
                style: TextStyle(color: Colors.black),
              ))),
          body: ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            progressIndicator: CircularProgressIndicator(color: kAppColor),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subject',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: kTextFieldColor,
                            ),
                            child: DropdownButtonFormField<String>(
                              key: assignSubject,
                              elevation: 0,
                              //  underline: Container(),
                              value: subjectName,
                              hint: const Text('Select Class'),
                              isExpanded: true,

                              iconSize: 30,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: kAppColor,
                              ),
                              items: model.listOfSubjects
                                  .map((subject) =>
                                      buildSubject(subject.subjectName))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  subjectName = value;
                                  model.assignSubjects.subjectName =
                                      value.toString();
                                  final selectedSubject = model.listOfSubjects
                                      .firstWhere((element) =>
                                          element.subjectName == value);
                                  model.assignSubjects.subjectId =
                                      selectedSubject.subjectId;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Fill the field";
                                } else {}
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Class',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: kTextFieldColor,
                            ),
                            child: DropdownButtonFormField<String>(
                              key: assignClassNo,
                              elevation: 0,
                              //  underline: Container(),
                              value: classNoo,
                              hint: const Text('Select Class'),
                              isExpanded: true,

                              iconSize: 30,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: kAppColor,
                              ),
                              items: model.listOfClasses
                                  .map(buildClassNo)
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  classNoo = value;
                                  model.assignSubjects.classId =
                                      value == "1st Year" ? 1 : 2;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Fill the field";
                                } else {}
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Program',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: kTextFieldColor,
                            ),
                            child: DropdownButtonFormField<String>(
                              key: assignProgremMen,
                              elevation: 0,
                              //  underline: Container(),
                              value: program,
                              hint: const Text('Select Program'),
                              isExpanded: true,
                              iconSize: 30,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: kAppColor,
                              ),
                              items: model.listOfPrograms
                                  .map(buildProgram)
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  this.program = value;
                                  model.assignSubjects.programId =
                                      value == "Computer Sciences"
                                          ? 1
                                          : value == 'Pre-Engineering'
                                              ? 2
                                              : 3;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Fill the field";
                                } else {}
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Section',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: kTextFieldColor,
                            ),
                            child: DropdownButtonFormField<String>(
                              key: assignSectionMen,
                              elevation: 0,
                              //  underline: Container(),
                              value: section,
                              hint: const Text('Select Section'),
                              isExpanded: true,
                              iconSize: 30,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: kAppColor,
                              ),
                              items: model.listOfSection
                                  .map(buildSection)
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  this.section = value;
                                  model.assignSubjects.section =
                                      value.toString();
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Fill the field";
                                } else {}
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 20, top: 5, bottom: 5),
                        child: signIn_login_Btn_widget(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  await model.assignASubject(context);
                                  classNoo = null;
                                  section = null;
                                  program = null;
                                  subjectName = null;
                                  setState(() {});
                                } catch (e) {}
                              }

                              // model.announcement.title = title.text;
                              // model.announcement.description = description.text;
                              // model.addAnnouncement(widget.screenIndex, context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => UploadVideoLecture()));
                            },
                            containerText: 'Register'),
                      ),
                    ],
                  ),
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
