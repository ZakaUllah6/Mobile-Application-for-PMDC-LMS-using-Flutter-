import 'package:flutter/material.dart';

import '../constants/constants.dart';
class RowWidget extends StatelessWidget {
   RowWidget({
    required this.tileName,
    required this.seeAllText,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String tileName;
  final String seeAllText;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tileName.toString(),style: kTextStyle,),
          Text(seeAllText.toString()),
        ],
      ),
    );
  }
}