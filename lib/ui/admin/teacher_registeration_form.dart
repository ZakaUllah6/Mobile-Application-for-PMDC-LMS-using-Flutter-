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

class TeacherRegisterationForm extends StatefulWidget {
  TeacherRegisterationForm({Key? key}) : super(key: key);

  @override
  State<TeacherRegisterationForm> createState() =>
      _TeacherRegisterationFormState();
}

class _TeacherRegisterationFormState extends State<TeacherRegisterationForm> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
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
  String? section;
  String? program;
  String? classNoo;

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
                'Teacher Registeration',
                style: TextStyle(color: Colors.black),
              ))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    imageAlertDialoge(onpressCamera: () async {
                                      await model.pickImageCamera();
                                    }, onpressGallery: () async {
                                      await model.pickImageGallery();
                                    }));

                            // model.pic();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                                radius: 70,
                                backgroundImage: model.imageee == null
                                    ? AssetImage('assets/images/camera.png')
                                        as ImageProvider
                                    : NetworkImage(
                                        model.imageee!,
                                        //   fit: BoxFit.cover,
                                      ) as ImageProvider),
                          ),
                        ),
                        Text(
                          'Teacher Id',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          chapterNameController: model.teacherId,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill the field";
                            } else {}
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Teacher Name',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          chapterNameController: model.teachername,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            } else {}
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Qualification',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: model.teacherQualification,
                          keyboardType: TextInputType.name,
                          cursorColor: kAppColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: InputBorder.none,
                            fillColor: kTextFieldColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            } else {}
                            return null;
                          },
                          // maxLines: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Date Of Birth',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            } else {}
                            return null;
                          },
                          readOnly: true,
                          decoration:
                              InputDecoration(hintText: "Enter Date Of Birth"),
                          controller: model.teacherDOB,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000, 1, 1),
                              firstDate: DateTime(1980, 1, 1),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              model.teacherDOB.text =
                                  DateFormat('dd MMMM yyyy').format(date);
                              model.teacher.age =
                                  (date.difference(DateTime.now()).inDays % 365)
                                      .toInt();
                              model.teacher.dateOfBirth = model.teacherDOB.text;

                              print("Date Of Birth : ${model.teacher.age}");
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          chapterNameController: model.teacherPhoneNo,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            } else {}
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          chapterNameController: model.teacherPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            } else {}
                            return null;
                          },
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
                            if (model.formKey.currentState!.validate()) {
                              if (model.imageee != null) {
                                await model.addTeacher(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Pick Student Image")));
                              }
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
