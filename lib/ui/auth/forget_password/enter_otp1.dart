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

class EnterIdForOtp extends StatefulWidget {
  String type;
  EnterIdForOtp({required this.type, Key? key}) : super(key: key);

  @override
  State<EnterIdForOtp> createState() => _EnterIdForOtpState();
}

class _EnterIdForOtpState extends State<EnterIdForOtp> {
  TextEditingController studentId = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

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
                'Forget Password',
                style: TextStyle(color: Colors.black),
              ))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Enter Your Id',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      chapterNameController: studentId,
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 20, top: 5, bottom: 5),
                      child: signIn_login_Btn_widget(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              if (widget.type == 'student') {
                                model.getStudentForgot(studentId.text, context);
                              } else if (widget.type == 'teacher') {
                                model.getTeacherForgot(studentId.text, context);
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
                          containerText: 'Send OTP'),
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
