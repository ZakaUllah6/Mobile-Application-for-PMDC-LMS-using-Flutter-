// import 'package:flutter/material.dart';
// import 'package:pmdccolleges_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/upload_screen.dart';
// import 'package:pmdccolleges_flutter/widgets/signin_login_btn_widget.dart';

// import '../../../../../constants/constants.dart';

// class TeacherVideoLectureScreen extends StatefulWidget {
//   int index;
//   TeacherVideoLectureScreen({required this.index, Key? key}) : super(key: key);

//   @override
//   State<TeacherVideoLectureScreen> createState() =>
//       _TeacherVideoLectureScreenState();
// }

// class _TeacherVideoLectureScreenState extends State<TeacherVideoLectureScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: kAppColor,
//               ),
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Padding(
//                   padding: const EdgeInsets.only(left: 3.0),
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     size: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           iconTheme: const IconThemeData(
//             color: Colors.black,
//           ),
//           title: const Center(
//               child: Text(
//             'Video Lectures',
//             style: TextStyle(color: Colors.black),
//           ))),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width * 0.5,
//                     right: 10,
//                     top: 5,
//                     bottom: 5),
//                 child: signIn_login_Btn_widget(
//                     onTap: () {
//                       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadVideoLecture()));
//                     },
//                     containerText: 'Add Lectures'),
//               ),

//               ///Only this container to go to next screen
//               CustomVideosConatiner(
//                 containerColor: kLightPinkColor,
//                 onTap: () {
//                   //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewVideoScreen()));
//                 },
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               CustomVideosConatiner(
//                 containerColor: kLightBlueColor,
//                 onTap: () {},
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               CustomVideosConatiner(
//                 containerColor: kLightCreemColor,
//                 onTap: () {},
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               CustomVideosConatiner(
//                 containerColor: kLightPinkColor,
//                 onTap: () {},
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomVideosConatiner extends StatefulWidget {
//   final Color containerColor;
//   VoidCallback onTap;

//   CustomVideosConatiner(
//       {Key? key, required this.containerColor, required this.onTap})
//       : super(key: key);

//   @override
//   State<CustomVideosConatiner> createState() => _CustomVideosConatinerState();
// }

// class _CustomVideosConatinerState extends State<CustomVideosConatiner> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.onTap,
//       child: Container(
//         padding: EdgeInsets.all(5),
//         height: 220,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: widget.containerColor,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: const [
//                       Text(
//                         'Chapter Name:',
//                         style: TextStyle(color: Colors.white, fontSize: 14),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Operating System',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: const [
//                       Text(
//                         'Chapter No:',
//                         style: TextStyle(color: Colors.white, fontSize: 14),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         '1',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               Text(
//                 'Topic',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Multiprogramming And\nMultiProcessing ',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 21,
//                           fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.justify),
//                   Container(
//                     height: 35,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: const Color(0xfff06709),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'View',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     'Teacher:',
//                     style: TextStyle(fontSize: 11, color: Colors.white),
//                   ),
//                   Text(
//                     'Muhammad Ishaq',
//                     style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Date:',
//                     style: TextStyle(fontSize: 11, color: Colors.white),
//                   ),
//                   Text(
//                     '27-Jan-2023',
//                     style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
