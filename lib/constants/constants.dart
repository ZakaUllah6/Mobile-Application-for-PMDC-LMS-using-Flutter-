import 'dart:math';

import 'package:flutter/material.dart';

const kTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17);
const kBlueColor = Color(0xff4C69E6);
const kLightBlueColor = Color(0xff3E8DFD);
const kGreenColor = Color(0xff37C396);
const kLightPinkColor = Color(0xffFF988B);
const kLightCreemColor = Color(0xffFFCD90);
const kPinkColor = Color(0xffE877EF);
const kLightBlackColor = Color(0xff565153);
const kAppColor = Color(0xffE67926);
const kTextFieldColor = Color(0xffF2F3F7);

List<Color> randomColors = [
  Color(0xffFFDECF),
  Color(0xffFFCD90),

  Color(0xffE3DEFF),

  Color(0xffF5F5F5),
  // add more colors as needed
];

Color getRandomColor() {
  final random = Random();
  return randomColors[random.nextInt(randomColors.length)];
}
