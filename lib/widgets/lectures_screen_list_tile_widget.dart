import 'package:flutter/material.dart';

import '../constants/constants.dart';

class LecturesScreenListTile extends StatelessWidget {
  const LecturesScreenListTile({
    required this.subjectName,
    required this.videosText,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final  String subjectName;
  final String videosText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1,color: Colors.grey.withOpacity(.2))

          ),
          child:ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color:  kBlueColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Image.asset('assets/images/subject_img.png'),
              ),
              title:   Text(subjectName.toString(),style: kTextStyle),
              trailing: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kAppColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(videosText.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              )
          )
      ),
    );
  }
}
