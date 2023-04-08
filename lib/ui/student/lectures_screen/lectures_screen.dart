import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/ui/student/lectures_screen/zoom_lectures/zoom_lectures.dart';
import 'package:pmdc_version_4_flutter/widgets/lectures_screen_list_tile_widget.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Center(
              child: Text(
            'Lectures ',
            style: TextStyle(color: Colors.black),
          )),
        ),
        drawer: const Drawer(
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                LecturesScreenListTile(
                  subjectName: 'Computer Science',
                  videosText: '2 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Physics',
                  videosText: '5 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Biology',
                  videosText: '8 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Chemistry',
                  videosText: '2 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Maths',
                  videosText: '7 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'English',
                  videosText: '3 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Urdu',
                  videosText: '1 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Islamyat',
                  videosText: '6 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                LecturesScreenListTile(
                  subjectName: 'Pak Studies',
                  videosText: '3 videos',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),

                ///TODO:We can move from here to zoom lectures screen
                LecturesScreenListTile(
                  subjectName: 'Zoom Lectures',
                  videosText: '9 videos',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ZoomLecturesScreen()));
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ));
  }
}
