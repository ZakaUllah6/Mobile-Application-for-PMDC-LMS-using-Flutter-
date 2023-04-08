import 'package:flutter/material.dart';

import '../constants/constants.dart';
class DateSheetContainerWidgets extends StatelessWidget {
  const DateSheetContainerWidgets({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(text.toString(),textAlign: TextAlign.center,style:TextStyle(color: kAppColor,fontWeight:FontWeight.w600))),
    );
  }
}
