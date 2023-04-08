import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/subject_details_widgets.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

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
          'Test ',
          style: TextStyle(color: Colors.black),
        )),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///NO Quiz For You Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.7,
                  decoration: BoxDecoration(
                    color: kAppColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/classes_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'No Quiz For You',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),

              ///Container for Subjects Details
              const SubjectDetailsWidgets(
                subjectName: 'Computer Science',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'English',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Physics',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Biology',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Chemistry',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Maths',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Urdu',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Islamyat',
              ),
              const SizedBox(height: 5),
              const SubjectDetailsWidgets(
                subjectName: 'Pak Studies',
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
