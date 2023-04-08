import 'package:flutter/material.dart';

import '../constants/constants.dart';
class SubjectSetailsScreenWidget extends StatelessWidget {
  SubjectSetailsScreenWidget({
    required this .containerColor,
    required this.containerIcon,
    required this.iconColor,
    required this.titleText,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final containerColor;
  final IconData containerIcon;
  final String titleText;
  VoidCallback onTap;
  final iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1,color: Colors.grey.withOpacity(.2))

          ),
          child:Center(
            child: ListTile(
                onTap:  onTap,
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: containerColor,
                    // color:  kBlueColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: Icon(containerIcon,color: iconColor,size: 30,),
                  // child: Image.asset('assets/images/subject_img.png'),
                ),
                title:   Text(titleText.toString(),style: kTextStyle),
                trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,)
            ),
          )
      ),
    );
  }
}
