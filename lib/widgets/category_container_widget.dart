import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CategoryContainerWidget extends StatelessWidget {
  const CategoryContainerWidget({
    required this.containerColor,
    required this.containerImage,
    required this.containerText,
    Key? key,
  }) : super(key: key);
  final Color containerColor;
  final containerImage;
  final String containerText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: containerImage,
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                containerText,
                style: kTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
