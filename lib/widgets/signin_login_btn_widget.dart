import 'package:flutter/material.dart';

import '../constants/constants.dart';
class signIn_login_Btn_widget extends StatelessWidget {
  signIn_login_Btn_widget({
    required this.onTap,
    required this.containerText,
    Key? key,
  }) : super(key: key);

  final String containerText;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kAppColor,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Center(child: Text(containerText,style: const TextStyle(fontSize: 17,color: Colors.white),)),
      ),
    );
  }
}