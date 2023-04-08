import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';
import 'package:pmdc_version_4_flutter/widgets/custom_textfield.dart';
import 'package:pmdc_version_4_flutter/widgets/signin_login_btn_widget.dart';

import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';

const String staticAssetsPath = "assets/images";

class AnnouncementScreen extends StatefulWidget {
  String title;
  int screenIndex;
  bool update;
  AnnouncementScreen(
      {required this.title,
      required this.screenIndex,
      required this.update,
      Key? key})
      : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final item = ['item1', 'item2', 'item3'];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherHomeScreenProvider>(builder: (context, model, ch) {
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
              'Upload Announcement',
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Announcement Title',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          chapterNameController: title,
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
                        TextFormField(
                          controller: description,
                          keyboardType: TextInputType.name,
                          cursorColor: kAppColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: InputBorder.none,
                            fillColor: kTextFieldColor,
                            filled: true,
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 20, top: 5, bottom: 5),
                      child: signIn_login_Btn_widget(
                          onTap: () {
                            if (model.formKey.currentState!.validate()) {}
                            model.announcement.title = title.text;
                            model.announcement.description = description.text;
                            model.addAnnouncement(widget.screenIndex, context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UploadVideoLecture()));
                          },
                          containerText: 'Post'),
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
