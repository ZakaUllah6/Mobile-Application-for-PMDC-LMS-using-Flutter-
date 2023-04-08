import 'package:flutter/material.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';

import '../constants/constants.dart';

class LibraryScreensConainerWidget extends StatelessWidget {
  Library libraryBooks;
  LibraryScreensConainerWidget({
    required this.libraryBooks,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kLightBlueColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Serial No. ${libraryBooks.sNo}',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Book Name: ${libraryBooks.bookName}',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Issued Date:',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                    SizedBox(
                      width: 2,
                    ),
                    Text('${libraryBooks.givenDate}',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
