import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';

class imageAlertDialoge extends StatelessWidget {
  Function()? onpressCamera;
  Function()? onpressGallery;
  imageAlertDialoge(
      {required this.onpressCamera, required this.onpressGallery, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AlertDialog(
        title: Text('Choose an Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onpressCamera,
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/camera.png'),
                    color: kAppColor,
                  ),
                  SizedBox(width: 10),
                  Text('Camera'),
                ],
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: onpressGallery,
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/Vector (11).png'),
                    color: kAppColor,
                  ),
                  SizedBox(width: 10),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
