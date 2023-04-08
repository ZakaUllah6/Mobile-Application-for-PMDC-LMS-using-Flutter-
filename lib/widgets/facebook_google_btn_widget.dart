import 'package:flutter/material.dart';
class facebook_google_btn_widget extends StatelessWidget {
  const facebook_google_btn_widget({
    required this.containerColors,
    required this.containerImage,
    required this.containerText,
    required this.textColor,
    Key? key,
  }) : super(key: key);
  final  Color? containerColors;
  final containerImage;
  final containerText;
  final textColor;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(0.0),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:containerColors,
            border: Border.all(color: Colors.grey.withOpacity(.5),width: 1)

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            containerImage,
            Text(containerText,style: TextStyle(color: textColor,fontSize: 15),),
            Container(),

          ],
        ),
      ),
    );
  }
}
